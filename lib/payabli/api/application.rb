# The MIT License (MIT)
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

module Payabli
  module Api
    # Contains all the API calls for the Application resource.
    # Take a look at our API Documentation on theresource (https://docs.payabli.com/reference/addapplication)
    # for more information about this.
    #
    # @author [lostmahbles]

    module Application

      DEFAULT_OPTIONS = {
        org_type: 0
      }.freeze

      # Returns the current user's application information.
      #
      # @return [Payabli::Resource::application] Current user's application
      #
      # @example
      #   application = @client.get_application
      def get_application(opts)
        path = "/Boarding/read/#{opts[:id]}"
        Payabli::Resource::Application.new get(path)
      end

      # Creates a new Payabli application. The user will need to confirm the email address
      # to complete the creation process.
      # @option opts [String] email_address New user's email address
      #
      # @return [Payabli::Resource::application] New user's application
      #
      # @example
      #   application = @client.create_application email_address: 'newuser@example.com'
      def create_application(opts)
        response = Payabli::Resource::Application.new post('/Boarding/app', body: DEFAULT_OPTIONS.merge(opts))

        return response unless response.is_success

        get_application(id: response.response_data)
      end

      # Updates the current user's application Callback URL.
      # @option opts [String] callback_url New callback URL
      #
      # @return [Payabli::Resource::application] Updated application
      #
      # @example
      #   application = @client.update_application callback_url: 'https://www.example.com/callback'
      def update_application(id, opts)
        path = "/Boarding/app/#{id}"
        response = Payabli::Resource::Application.new put(path, body: opts)

        return response unless response.is_success

        get_application(id: response.response_data)
      end

      def get_external_link(id:, email:)
        path = "/Boarding/applink/#{CGI.escape(id.to_s)}/#{CGI.escape(email)}"
        Payabli::Resource::BaseResource.new(put(path)).response_data
      end
    end
  end
end
