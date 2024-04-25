class FollowsController < ApplicationController
  before_action :build_follow, only: :create
  before_action :find_follow_record, only: :destroy

  def create
    @follow = current_user.follows.build(followed_user_id: params[:following_id])
    if @follow.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @follow = Follow.find(params[:id])
    @follow.update(status: params[:status])
    redirect_to root_path, status: :see_other
  end

  def destroy
    @follow&.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def build_follow
    if params[:following_id].blank? || Follow.exists?(following_user_id: current_user,
                                                      followed_user_id: params[:following_id])
      redirect_to root_path
      return
    end

    @follow = current_user.follows.build(followed_user_id: params[:following_id])
  end

  def find_follow_record
    if params[:following_id].present?
      @follow = Follow.find_by(following_user_id: params[:id], followed_user_id: params[:following_id])
    elsif params[:follower_id].present?
      @follow = Follow.find_by(following_user_id: params[:follower_id], followed_user_id: params[:id])
    end
  end

  def follow_params
    params.require(:follow).permit(:status, :follower_id, :following_id)
  end
end
