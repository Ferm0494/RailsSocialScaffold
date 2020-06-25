class FriendshipsController < ApplicationController
  def create
    puts 'Hello world!'
    friendship = Friendship.new
    friendship.sender = current_user
    friendship.receiver = User.find(params[:id])
    friendship.status = 'Pending'
    friendship.save
    redirect_to root_path
  end

  def index
    @friendships_requests = current_user.friendships_requests.where('other_user_id = ?', current_user.id)
  end

  def destroy
    Friendship.destroy(params[:id])
    redirect_to root_path
  end

  def update
    Friendship.update(params[:id], status: 'Active')
    redirect_to root_path
  end
end
