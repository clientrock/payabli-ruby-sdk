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
    # Contains all the API calls for the Organization resource.
    # Take a look at our API Documentation on theresource (https://docs.payabli.com/reference/addorganization)
    # for more information about this.
    #
    # @author [lostmahbles]

    module Organization

      # Returns the current user's organization information.
      #
      # @return [Payabli::Resource::organization] Current user's organization
      #
      # @example
      #   organization = @client.get_organization
      def get_organization(opts)
        path = "/Organization/read/#{opts[:id]}"
        Payabli::Resource::Organization.new get(path)
      end

      # Creates a new Payabli organization. The user will need to confirm the email address
      # to complete the creation process.
      # @option opts [String] email_address New user's email address
      #
      # @return [Payabli::Resource::organization] New user's organization
      #
      # @example
      #   organization = @client.create_organization email_address: 'newuser@example.com'
      def create_organization(opts)
        response = Payabli::Resource::Organization.new post('/Organization', body: opts.merge(
          org_type: 0
        ))

        return response unless response.is_success

        get_organization(id: response.response_data)
      end

      # Updates the current user's organization Callback URL.
      # @option opts [String] callback_url New callback URL
      #
      # @return [Payabli::Resource::organization] Updated organization
      #
      # @example
      #   organization = @client.update_organization callback_url: 'https://www.example.com/callback'
      def update_organization(id, opts)
        path = "/Organization/#{id}"
        response = Payabli::Resource::Organization.new put(path, body: opts)

        return response unless response.is_success

        get_organization(id: response.response_data)
      end
    end
  end
end
