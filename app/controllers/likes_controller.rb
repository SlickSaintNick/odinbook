class LikesController < ApplicationController
  before_action :set_likeable, only: [:create]

  def create
    if Like.exists?(user: current_user, likeable: @likeable)
      redirect_back_or_to root_path
      return
    end

    @like = @likeable.likes.build(user: current_user)

    if @like.save
      redirect_back_or_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy

    redirect_back_or_to root_path, status: :see_other
  end

  private

  def set_likeable
    klass = params[:likeable_type].capitalize.constantize
    @likeable = klass.find(params[:likeable_id])
  end
end
