class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships_requests, lambda { |user|
                                    unscope(where: :user_id)
                                      .where("status = 'Pending'")
                                      .where('(friendships.other_user_id = :user_id OR friendships.user_id = :user_id) AND friendships.id % 2 = 1',
                                             user_id: user.id)
                                  },
           class_name: 'Friendship'

  has_many :friends, lambda { |user|
                       unscope(where: :user_id)
                         .where("status = 'Active'")
                         .where('friendships.user_id = :user_id  ',
                                user_id: user.id)
                     },
           class_name: 'Friendship'

  def my_friends
    users = []
    friends.each do |friendship|
      users << friendship.sender unless users.include?(friendship.sender)
      users << friendship.receiver unless users.include?(friendship.receiver)
    end

    users
  end
end
