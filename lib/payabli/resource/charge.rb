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
    # Take a look at the API Documentation on the Charge resource (https://docs.payabli.com/reference/getpaid)
    # for more information about this.
    #

    class Charge < BaseResource

      STATUS_APPROVED = [1]
      STATUS_AUTHORIZED = [11]
      STATUS_DECLINED = [2, 3]
      STATUS_VOIDED = [5]
      STATUS_HELD = [-5]
      STATUS_FAILED = [-1, 0]

      # Creates a new Charge from a hash. If key defined then Charge data with be the value of hash[key], otherwise the hash itself.
      # @param hash [Hash] Charge's data
      # @param key [String] (Charge) key of the hash, point to where Charge data is. If nil, then the hash itself.
      #
      # @return [Payabli::Resource::Charge] an Charge
      def initialize(hash, keys)
        super
      end

      def id
        reference_id || payment_trans_id
      end

      def succeeded?
        STATUS_APPROVED.include? status
      end

      def failed?
        !succeeded?
      end

      def full_charge?
        trans_status.present?
      end

      def status
        return trans_status if full_charge?

        result_code
      end

      def status_message
        response_data.response_code_text if full_charge?

        result_text
      end
    end
  end
end
