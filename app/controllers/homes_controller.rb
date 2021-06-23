class HomesController < ApplicationController

  def index
    user = User.all
    @users = user.where.not(id:current_user.id).order(:updated_at) 
    if params[:search].present?
      @users = @users.where("email LIKE ? or full_name LIKE ?", "%#{params[:search]}%" , "%#{params[:search]}%")
    end
  end

  def pending_invitations
    users = FriendList.users(current_user.id,false)
    @users = users.where.not(id:current_user.id).order(:updated_at)     
  end

  def friends
    users = FriendList.users(current_user.id,true)
    @users = users.where.not(id:current_user.id).order(:updated_at) 
  end

  def  send_request
    FriendList.create(sender_id:current_user.id,receiver_id:params[:id])
    redirect_to root_path
  end

  def profile
    @user = User.find(params[:id])
    users = FriendList.users(@user.id,true)
    @users = users.where.not(id:[current_user.id,params[:id]]).order(:updated_at)

  end

  def accept_request
    FriendList.where(sender_id: params[:id], receiver_id: current_user.id, status: false).update(status:true)
    redirect_to pending_invitations_homes_path
  end

end