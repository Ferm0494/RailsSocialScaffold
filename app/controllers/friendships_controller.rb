class FriendshipsController < ApplicationController
  before_action :getting_params, only: [:destroy, :update]
  

  def getting_params 
    friendship = Friendship.find(params[:id])
    @user1 = friendship.sender
    @user2 = friendship.receiver  
  end

  def create
    receiver = User.find(params[:id])
    friendship_sender, friendship_receiver = Friendship.new, Friendship.new
    friendship_receiver.sender,friendship_sender.sender = receiver ,current_user
    friendship_receiver.receiver,friendship_sender.receiver = current_user, receiver 
    friendship_receiver.status, friendship_sender.status = 'Pending', 'Pending'
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
    Friendship.where("(user_id= :id1 AND other_user_id= :id2 ) OR (user_id = :id2 AND other_user_id = :id1)",id1: @user1.id, id2: @user2.id).each{
      |f|
      Friendship.destroy(f.id)
    }
    redirect_to root_path
  end

  def update
    
    Friendship.where("(user_id= :id1 AND other_user_id= :id2 ) OR (user_id = :id2 AND other_user_id = :id1)",id1: @user1.id, id2: @user2.id).each{
      |f|
      Friendship.update(f.id, status: "Active")
    }
     redirect_to root_path
  end
end
