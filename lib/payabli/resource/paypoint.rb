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
    # Contains information about an Paypoint and its settings.
    # Take a look at the API Documentation on the Paypoint resource (https://docs.payabli.com/reference/https://docs.payabli.com/reference/getentryconfig)
    # for more information about this.
    #

    class Paypoint < BaseResource

      # Creates a new Paypoint from a hash. If key defined then Paypoint data with be the value of hash[key], otherwise the hash itself.
      # @param hash [Hash] Paypoint's data
      # @param key [String] (Paypoint) key of the hash, point to where Paypoint data is. If nil, then the hash itself.
      #
      # @return [Payabli::Resource::Paypoint] an Paypoint
      def initialize(hash, keys = ['responseData', 'Paypoint'])
        super
      end

      def id
        id_paypoint
      end
    end
  end
end
