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

require 'payabli/version'
require 'payabli/configuration'
require 'payabli/client'

module Payabli
  extend Configuration

  # If Payabli module doesn't respond to method, then delegates it to Payabli::Client
  # @param method [Symbol] method name
  # @param *args [Array] arguments passed into the method
  # @param &block [Block] a block passed into the method
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # If Payabli module doesn't respond to method, asks Payabli::Client whether it responded or not
  # @param method [Symbol] method name
  def self.respond_to?(method, include_all=false)
    return super || client.respond_to?(method)
  end

  private

  def self.client
    Payabli::Client.new
  end
end
