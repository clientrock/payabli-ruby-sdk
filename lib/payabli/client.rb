# The MIT License (MIT)
#
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'faraday'
require 'multi_json'
require 'mime/types'
require 'payabli/error'
require 'payabli/configuration'
require 'payabli/resource'
require 'payabli/api'
require 'logger'

module Payabli

  # You'll need the Payabli::Client to do just about everything, from creating
  # signatures to updating account information.
  #
  class Client
    include Api::Application
    include Api::Charge
    include Api::Method
    include Api::Notification
    include Api::Organization
    include Api::Paypoint

    attr_accessor :end_point, :oauth_end_point, :api_version, :user_agent, :client_id, :client_secret, :email_address, :password, :api_key, :auth_token, :logging, :log_level, :proxy_uri, :proxy_user, :proxy_pass, :timeout

    ERRORS = {
      400 => Error::BadRequest,
      401 => Error::Unauthorized,
      402 => Error::PaidApiPlanRequired,
      403 => Error::Forbidden,
      404 => Error::NotFound,
      405 => Error::MethodNotAllowed,
      409 => Error::Conflict,
      410 => Error::Gone,
      429 => Error::ExceededRate,
      500 => Error::InternalServerError,
      502 => Error::BadGateway,
      503 => Error::ServiceUnavailable
    }

    # Initiates a new Payabli Client
    # @option opts [String] email_address The account's email address. (optional)
    # @option opts [String] password The account's password, if authenticating with an email_address. (optional)
    # @option opts [String] api_key The account's API key.
    #
    # @return [Payabli::Client] a new Payabli::Client
    #
    # @example Authenticating with username and password
    #   client = Payabli::Client.new email_address: 'me@example.com', password: 'mypassword'
    #
    # @example Authenticating with API key
    #   client = Payabli::Client.new api_key: '1234567890123456789012345678901234567890123456789012345678901234'
    def initialize(opts={})
      options = Payabli.options.merge(opts)
      Payabli::Configuration::VALID_OPTIONS_KEYS.each do |key|
        self.send("#{key}=", options[key])
      end
    end

    # Makes an HTTP GET request
    # @param path [String] Relative path of the request.
    # @option options [Hash] params Params of the URL.
    def get(path, options={})
      response = request(path, :get, options)
      validate response
      parsed_response = parse response
      data = { headers: response.headers, body: parsed_response }
    end

    # Makes an HTTP POST request
    # @param path [String] Relative path of the request.
    # @option options [Hash] params Params of the URL.
    # @option options [Hash] body Body of the request.
    def post(path, options={})
      response = request(path, :post, options)
      validate response
      parsed_response = parse response
      data = { headers: response.headers, body: parsed_response }
    end

    # Makes an HTTP PUT request
    # @param path [String] Relative path of the request.
    # @option options [Hash] params Params of the URL.
    # @option options [Hash] body Body of the request.
    def put(path, options={})
      response = request(path, :put, options)
      validate response
      parsed_response = parse response
      data = { headers: response.headers, body: parsed_response }
    end

    # Makes an HTTP DELETE request
    # @param path [String] Relative path of the request.
    # @option options [Hash] Params of the URL.
    def delete(path, options={})
      response = request(path, :delete, options)
      validate response
      parsed_response = parse response
      data = { headers: response.headers, body: parsed_response }
    end

    private

    def request(path, method, options={})
      make_connection(options).send method do |request|
        if options[:oauth_request]
          request.url path, options[:params]
        else
          request.url "#{api_version}#{path}", options[:params]
        end
        request.body = camelize(options[:body]).to_json
      end
    end

    def make_connection options
      url = options[:oauth_request] ? oauth_end_point : end_point

      if @logging
        logger = Logger.new(STDOUT)
        logger.level = @log_level
      end

      connection = Faraday.new(:url => url, :headers => { user_agent: user_agent }) do |faraday|
        faraday.request :multipart
        faraday.request :url_encoded
        faraday.response :logger, logger if @logging
        faraday.adapter :net_http
        faraday.options[:timeout] = timeout if timeout
      end

      if options[:no_auth]
      elsif auth_token
        connection.authorization :Bearer, auth_token
      elsif api_key
        connection.headers['Accept'] = 'application/json'
        connection.headers['Content-Type'] = 'application/*+json'
        connection.headers['requestToken'] = api_key
      elsif email_address
        connection.basic_auth email_address, password
      else
      end
      if proxy_uri
        connection.options.proxy = {
          :uri      => proxy_uri.nil? ? nil : URI(proxy_uri),
          :user     => proxy_user,
          :password => proxy_pass
        }
      end
      connection
    end

    def validate(response)
      if response.status >= 400
        error_class = ERRORS[response.status] || Payabli::Error::UnknownError
        error = error_class.new(response.status, response.body, response.env.url.to_s)
        raise error
      end
    end

    def parse(response)
      if response['content-type'] == 'application/pdf'
        response.body
      elsif response['content-type'] == 'application/zip'
        response.body
      elsif response.body.strip.empty?
        {}
      else
        MultiJson.load response.body.strip
      end
    end

    def MIMEfromName(name)
      parts = name.split('.')
      # defaults to pdf if no extension provided
      if parts.length < 2
        return 'application/pdf'
      end
      extension = parts[-1]
      types = MIME::Types.type_for(extension)
      types[0]
    end

    def MIMEfromIO(file)
      begin
        path = File.path file
        MIMEfromName path
      # in case of error in type detection, return default type
      rescue
        return 'application/pdf'
      end
    end

    def prepare_files(opts)
      if opts[:files]
        opts[:files].each_with_index do |file, index|
          if file.is_a? String
            if File.file?(file)
              mime_type = MIMEfromName file
              opts[:"file[#{index}]"] = Faraday::UploadIO.new(file, mime_type)
            else
              raise Payabli::Error::FileNotFound.new "#{file} was not found on the filesystem"
            end
          elsif file.is_a? File
            mime_type = MIMEfromIO file
            opts[:"file[#{index}]"] = Faraday::UploadIO.new(file, mime_type)
          elsif file.is_a? StringIO
            opts[:"file[#{index}]"] = Faraday::UploadIO.new(file, 'application/pdf')
          elsif defined? ActionDispatch::Http::UploadedFile
            if file.is_a? ActionDispatch::Http::UploadedFile
              mime_type = MIMEfromIO file
              opts[:"file[#{index}]"] = UploadIO.new(file.tempfile, mime_type, file.original_filename)
            end
          else
            raise Payabli::Error::NotSupportedType.new "#{file.class} is not a supported. Must be a string or ActionDispatch::Http::UploadedFile"
          end
        end
        opts.delete(:files)
      elsif opts[:file_urls]
        opts[:file_urls].each_with_index do |file, index|
          opts[:"file_url[#{index}]"] = file
        end
        opts.delete(:file_urls)
      end
    end

    # Takes options given to an API endpoint as a hash, plus an array of parameters (as symbols), and creates a
    # query string out of any listed parameters present (that also have values)

    def create_query_string(opts, parameterList)
        result = ""
        is_first = true
        parameterList.each do |param|
            if (opts.has_key?(param) && opts[param])
                if (!is_first)
                    result += "&"
                end
                is_first = false
                result += "#{param}=#{opts[param]}"
            end
        end
        if (result.length > 0)
            result = "?" + result
        end
        result
    end

    def camelize(hash)
      return nil if hash.blank?

      hash.inject({}) do |result, (key, value)|
        new_key = key.to_s.gsub(/_(.)/) { $1.upcase }
        new_value = value.is_a?(Hash) ? camelize(value) : value
        result[new_key] = new_value
        result
      end
    end

    def prepare(opts, key)
      return unless opts[key]
      opts[key].each_with_index do |value, index|
        if value.is_a? String
          opts[:"#{key}[#{index}]"] = value
        else
          if value[:role]
            opts[:"#{key}[#{value[:role]}]"] = value
            value.delete(:role)
          else
            opts[:"#{key}[#{index}]"] = value
          end
        end
      end
      opts.delete(key)
    end
  end
end
