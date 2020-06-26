class FriendshipsController < ApplicationController
  before_action :getting_params, only: %i[destroy update]

  def getting_params
    friendship = Friendship.find(params[:id])
    @user1 = friendship.sender
    @user2 = friendship.receiver
  end

  def create
    receiver = User.find(params[:id])
    friendship_sender = Friendship.new
    friendship_receiver = Friendship.new
    friendship_receiver.sender = receiver
    friendship_sender.sender = current_user
    friendship_receiver.receiver = current_user
    friendship_sender.receiver = receiver
    friendship_receiver.status = 'Pending'
    friendship_sender.status = 'Pending'
    friendship_sender.save
    friendship_receiver.save
    redirect_to root_path
  end

  def index
    @count = false
    @friendships_requests = current_user.friendships_requests
    @friendships_requests = @friendships_requests.where(other_user_id: current_user.id)
  end

  def destroy
    Friendship.where('(user_id= :id1 AND
    other_user_id= :id2 ) OR
    (user_id = :id2 AND other_user_id = :id1)',
                     id1: @user1.id, id2: @user2.id).each do |f|
      Friendship.destroy(f.id)
    end
    redirect_to root_path
  end

  def update
    Friendship.where('(user_id= :id1 AND
    other_user_id= :id2 ) OR
     (user_id = :id2 AND
      other_user_id = :id1)',
                     id1: @user1.id, id2: @user2.id).each do |f|
      Friendship.update(f.id, status: 'Active')
    end
    redirect_to root_path
  end
end
