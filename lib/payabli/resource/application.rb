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
    # Contains information about an Application and its settings.
    # Take a look at the API Documentation on the Application resource (https://docs.payabli.com/reference/addapplication)
    # for more information about this.
    #

    class Application < BaseResource

      # Creates a new Application from a hash. If key defined then Application data with be the value of hash[key], otherwise the hash itself.
      # @param hash [Hash] Application's data
      # @param key [String] (Application) key of the hash, point to where Application data is. If nil, then the hash itself.
      #
      # @return [Payabli::Resource::Application] an Application
      def initialize(hash, keys = nil)
        super
      end

      def id
        id_application
      end

      def link_data(email:)
        client.get_external_link(id: id, email: email)
      end
    end
  end
end
