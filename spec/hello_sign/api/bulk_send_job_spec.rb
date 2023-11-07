require 'spec_helper'

describe Payabli::Api::BulkSendJob do
  describe '#get_bulk_send_job' do
    before do
      stub_get('/bulk_send_job/1', 'bulk_send_job')
      @bulk_send = Payabli.get_bulk_send_job :bulk_send_job_id => 1
    end

    it 'should get the correct resource' do
      expect(a_get('/bulk_send_job/1')).to have_been_made
    end

    it 'should return response headers' do
      expect(@bulk_send.headers).to_not be_nil
    end

    it 'should return a Bulk Send Job' do
      expect(@bulk_send).to be_an Payabli::Resource::BulkSendJob
    end
  end

  describe '#get_bulk_send_jobs' do
    before do
      stub_get('/bulk_send_job/list', 'bulk_send_jobs')
      @bulk_send_jobs = Payabli.get_bulk_send_jobs({})
    end

    it 'should get the correct resource' do
      expect(a_get('/bulk_send_job/list')).to have_been_made
    end

    it 'returns reponse headers' do
      expect(@bulk_send_jobs.headers).to_not be_nil
    end

    it 'should return a ResourceArray' do
      expect(@bulk_send_jobs).to be_an Payabli::Resource::ResourceArray
    end

    it 'each of Array is a BulkSendJob' do
      expect(@bulk_send_jobs[0]).to be_an Payabli::Resource::BulkSendJob
    end

    it 'should return list_info as a BaseResource in results' do
      expect(@bulk_send_jobs[0].list_info).to be_an Payabli::Resource::BaseResource
    end

    it 'should return page numbers as an integer' do
      expect(@bulk_send_jobs[0].list_info.page).to be_an Integer
    end
  end
end
