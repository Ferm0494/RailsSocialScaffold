require 'rails_helper'
RSpec.describe Like, type: :model do
  context 'Validations for a like' do
    let(:user) { User.new(email: 'testing@testing.com', name: 'testing', password: 'foobar') }
    let(:post) { Post.new(content: 'Content for post') }
    let(:like) { Like.new }

    it 'Should be a valid like if theres a user and a post' do
      user.save
      post.user = user
      post.save
      like.post = post
      like.user = user
      expect(like).to be_valid
    end

    it 'Should not be valid like if theres no user' do
      user.save
      post.user = user
      post.save
      like.post = post
      like.user = nil
      expect(like).not_to be_valid
    end

    it 'Should not be valid like if theres no post' do
      user.save
      post.user = user
      post.save
      like.post = nil
      like.user = user
      expect(like).not_to be_valid
    end
  end
  context 'Assocs for like' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end
end
