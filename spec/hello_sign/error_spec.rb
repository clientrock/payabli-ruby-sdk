require 'spec_helper'

describe Payabli::Error do
  # another test to prove backwards compatibility
  it 'raises an error with any message' do
    error = Payabli::Error::Error.new(404, 'test error message', 'http://www.test.com')
    expect(error).to be_instance_of(Payabli::Error::Error)
  end

end
