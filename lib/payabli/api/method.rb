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
    # Contains all the API calls for the resource.
    # Take a look at our API Documentation on theresource (https://docs.payabli.com/reference/addpaypoint)
    # for more information about this.
    #
    # @author [lostmahbles]

    module Method

      # Returns a payment method
      #
      # @return [Payabli::Resource::Method] Payment method
      #
      # @example
      #   method = @client.get_method(id: '08c0ab0c-2fab-4eb0-a510-d355d5c286f4-939')
      def get_method(opts)
        if opts[:id].present?
          path = "/TokenStorage/#{opts[:id]}"
        else
          return nil
        end

        Payabli::Resource::Method.new get(path)
      end
    end
  end
end
