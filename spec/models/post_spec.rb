require 'rails_helper'
RSpec.describe Post, type: :model do
  context 'Validations on Post model' do
    let(:user) { User.new(email: 'testing@testing.com', name: 'testing', password: 'foobar') }
    let(:post) { Post.new(content: 'Content for post') }

    it 'Should be a valid post for init case content/user' do
      user.save
      post.user = user
      expect(post).to be_valid
    end
    it 'Should not be valid if post is empty' do
      user.save
      post.user = user
      post.content = ''
      expect(post).not_to be_valid
    end
  end

  context 'Assocs for Posts' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should belong_to(:user) }
  end
end
