require 'rails_helper'
RSpec.describe Friendship, type: :model do
  context 'Validation for friendship ' do
    let(:user1) { User.new(email: 'test@test.com', name: 'test', gravatar_url: 'Tested', password: 'foobar') }
    let(:user2) { User.new(email: 'test@test.com', name: 'test', gravatar_url: 'Tested', password: 'foobar') }
    let(:friendship) { Friendship.new(status: 'Pending') }

    it 'Creates a succesful friendship if user exists' do
      friendship.sender = user1
      friendship.receiver = user2
      expect(friendship).to be_valid
    end
    it 'Doesnt create a friendship if user doest exists' do
      friendship.sender = user1
      friendship.receiver = nil
      expect(friendship).not_to be_valid
    end
  end
end
