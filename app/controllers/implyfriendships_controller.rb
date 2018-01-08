class ImplyfriendshipsController < ApplicationController
  include SessionsHelper
  before_action :logged_in
  
 

  def create
    user=User.find_by_id(params[:friend_id]) 
    @implyfriendship = user.implyfriendships.build(:implyfriend_id => @current_user.id)
    if @implyfriendship.save
      #@user.implynum = @user.implynum + 1
      flash[:info] = "申请成功"
      redirect_to chats_path
    else
      flash[:error] = "无法申请添加好友"
      redirect_to chats_path
    end
  end

  def destroy
    @implyfriendship = current_user.implyfriendships.find_by(implyfriend_id: params[:user_id])
    @implyfriendship.destroy

    flash[:success] = "拒绝申请成功"
    redirect_to chats_path
  end

  private
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登录'}
    end
  end

end
