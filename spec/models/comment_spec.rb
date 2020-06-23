require 'rails_helper'
RSpec.describe Comment, type: :model do
     # rubocop:disable Layout/LineLength
  context 'Validations for comment' do
    let(:user) { User.new(email: 'testing@testing.com', name: 'testing', password: 'foobar') }
    let(:post) { Post.new(content: 'Content for post') }
    let(:comment) { Comment.new(content: 'Nice post!') }

    it 'Should be a valid comment if content not empty ' do
      user.save
      post.save
      comment.user = user
      comment.post = post
      expect(comment).to be_valid
    end

    it 'Should not be a valid comment if content not empty ' do
      user.save
      post.save
      comment.user = user
      comment.post = post
      comment.content = ''
      expect(comment).not_to be_valid
    end

    it 'Should not be valid if theres no post ' do
      user.save
      post.save
      comment.user = user
      comment.post = nil
      expect(comment).not_to be_valid
    end

    it 'Should not be valid if theres no user ' do
      user.save
      post.save
      comment.user = nil
      comment.post = post
      expect(comment).not_to be_valid
    end
  end
  context 'Assocs for Comments' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
  # rubocop:enable Layout/LineLength