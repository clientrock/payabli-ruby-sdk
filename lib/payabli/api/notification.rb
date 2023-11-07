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
    # Contains all the API calls for the Notification resource.
    # Take a look at our API Documentation on theresource (https://docs.payabli.com/reference/addnotification)
    # for more information about this.
    #
    # @author [lostmahbles]

    module Notification

      DEFAULT_OPTIONS = {
        owner_type: 0,
        method: 'web',
        frequency: 'untilcancelled',
        source: 'api'
      }.freeze

      # Returns the current user's notification information.
      #owne
      # @return [Payabli::Resource::notification] Current user's notification
      #
      # @example
      #   notification = @client.get_notification
      def get_notification(opts)
        path = "/Notification/#{opts[:id]}"
        Payabli::Resource::Notification.new get(path)
      end

      # Creates a new Payabli notification. The user will need to confirm the email address
      # to complete the creation process.
      # @option opts [String] email_address New user's email address
      #
      # @return [Payabli::Resource::notification] New user's notification
      #
      # @example
      #   notification = @client.create_notification email_address: 'newuser@example.com'
      def create_notification(opts)
        body = DEFAULT_OPTIONS.merge(opts)
        response = Payabli::Resource::Notification.new post('/Notification', body: body)

        return response unless response.is_success

        get_notification(id: response.response_data)
      end

      # Updates the current user's notification Callback URL.
      # @option opts [String] callback_url New callback URL
      #
      # @return [Payabli::Resource::notification] Updated notification
      #
      # @example
      #   notification = @client.update_notification callback_url: 'https://www.example.com/callback'
      def update_notification(id, opts)
        path = "/Boarding/app/#{id}"
        response = Payabli::Resource::Notification.new put(path, body: opts)

        return response unless response.is_success

        get_notification(id: response.response_data)
      end
    end
  end
end
