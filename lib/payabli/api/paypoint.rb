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
    # Contains all the API calls for the Paypoint resource.
    # Take a look at our API Documentation on theresource (https://docs.payabli.com/reference/addpaypoint)
    # for more information about this.
    #
    # @author [lostmahbles]

    module Paypoint

      # Returns the current user's paypoint information.
      #
      # @return [Payabli::Resource::paypoint] Current user's paypoint
      #
      # @example
      #   paypoint = @client.get_paypoint
      def get_paypoint(opts)
        if opts[:id].present?
          path = "/Paypoint/basicById/#{opts[:id]}"
        elsif opts[:entry_name]
          path = "/Paypoint/basic/#{opts[:entry_name]}"
        else
          return nil
        end

        Payabli::Resource::Paypoint.new get(path)
      end
    end
  end
end
