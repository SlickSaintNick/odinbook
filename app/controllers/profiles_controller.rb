class ProfilesController < ApplicationController
  before_action :find_profile_groups, only: [:index, :show]

  def index
    @not_followed = User.where.not(id: (current_user.following_user_ids + [current_user.id]))
  end

  def show
    @profile = Profile.find(params[:id])
    @posts = Post.where(user_id: @profile.user.id)
  end

  def new
    @profile = Profile.new
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def create
    @profile = current_user.create_profile(profile_params)

    if @profile.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to profile_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def find_profile_groups
    @follow_requests = current_user.following_users.where(follows: { status: 'pending_follow' })
    @followers = current_user.following_users.where(follows: { status: 'accepted_follow' })

    @requested_to_follow = current_user.followed_users.where(follows: { status: 'pending_follow' })
    @following = current_user.followed_users.where(follows: { status: 'accepted_follow' })

    @not_following = (User.where.not(id:
      (current_user.following_user_ids + [current_user.id])) + @requested_to_follow).uniq
  end

  def profile_params
    params.require(:profile).permit(:name, :bio, :role, :profile_image)
  end
end
