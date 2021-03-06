class Friendship < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'user_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'other_user_id'

  validates :sender, uniqueness: { scope: :receiver }
end
