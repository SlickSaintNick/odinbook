class FollowsController < ApplicationController
  before_action :find_follow_record, only: [:create, :destroy]

  def edit
  end

  def create
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

  def find_follow_record
    if params[:following_id].present?
      @follow = Follow.find_by(following_user_id: params[:id], followed_user_id: params[:following_id])
    elsif params[:follower_id].present?
      @follow = Follow.find_by(following_user_id: params[:follower_id], followed_user_id: params[:id])
    end
  end

  def status_params
    params.require(:follow).permit(:status, :follower_id, :following_id)
  end
end
