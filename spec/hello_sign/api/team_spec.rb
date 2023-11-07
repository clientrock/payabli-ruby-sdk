require 'spec_helper'

describe Payabli::Api::Team do
  describe '#get_team' do
    before do
      stub_get('/team', 'team')
      @team = Payabli.get_team
    end

    it 'should get the correct resource' do
      expect(a_get('/team')).to have_been_made
    end

    it 'should return response headers' do
      expect(@team.headers).to_not be_nil
    end

    it 'should return user\'s team' do
      expect(@team).to be_an Payabli::Resource::Team
    end
  end

  describe '#create_team' do
    before do
      stub_post('/team/create', 'team')
      @team = Payabli.create_team :name => 'Team Payabli'
    end

    it 'should get the correct resource' do
      expect(a_post('/team/create')).to have_been_made
    end

    it 'should return response headers' do
      expect(@team.headers).to_not be_nil
    end

    it 'should return information about a created team' do
      expect(@team.name).to eql('Team Payabli')
    end
  end

  describe '#update_team' do
    before do
      stub_post('/team', 'team')
      @team = Payabli.update_team :name => 'Team Payabli'
    end

    it 'should get the correct resource' do
      expect(a_post('/team')).to have_been_made
    end

    it 'should return response headers' do
      expect(@team.headers).to_not be_nil
    end

    it 'should return information about a updated team' do
      expect(@team.name).to eql('Team Payabli')
    end
  end

  describe '#destroy_team' do
    before do
      stub_post('/team/destroy', 'team')
      @team = Payabli.destroy_team
    end

    it 'should get the correct resource' do
      expect(a_post('/team/destroy')).to have_been_made
    end
  end

  describe '#add_member_to_team' do
    before do
      stub_post('/team/add_member', 'team')
      @team = Payabli.add_member_to_team :email_address => 'george@example.com'
    end

    it 'should return response headers' do
      expect(@team.headers).to_not be_nil
    end

    it 'should get the correct resource' do
      expect(a_post('/team/add_member')).to have_been_made
    end
  end

  describe '#remove_member_from_team' do
    before do
      stub_post('/team/remove_member', 'team')
      @team = Payabli.remove_member_from_team :email_address => 'george@example.com'
    end

    it 'should return response headers' do
      expect(@team.headers).to_not be_nil
    end

    it 'should get the correct resource' do
      expect(a_post('/team/remove_member')).to have_been_made
    end
  end
end
