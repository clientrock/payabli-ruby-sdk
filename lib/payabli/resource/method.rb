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
  module Resource
    # Contains information about a payment method
    # Take a look at the API Documentation on the Method resource (https://docs.payabli.com/reference/getmethod)
    # for more information about this.
    #

    class Method < BaseResource

      # Creates a new Method from a hash. If key defined then Method data with be the value of hash[key], otherwise the hash itself.
      # @param hash [Hash] Method's data
      # @param key [String] (Method) key of the hash, point to where Method data is. If nil, then the hash itself.
      #
      # @return [Payabli::Resource::Method] an Method
      def initialize(hash, keys = keys = ['responseData'])
        super
      end

      def id
        id_pmethod
      end
    end
  end
end
