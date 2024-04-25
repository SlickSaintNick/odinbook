class ProfilesController < ApplicationController
  before_action :set_following_profiles, only: [:index, :show]
  before_action :set_follower_profiles, only: [:show]

  def index
    @not_followed = User.where.not(id: (current_user.following_user_ids + [current_user.id]))
  end

  def show
    @profile = Profile.find(params[:id])
    @posts = Post.where(user_id: params[:id])
  end

  def new
    @profile = current_user.create_profile
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
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_following_profiles
    @following = current_user.followed_users.where(follows: { status: 'accepted_follow' })
    @pending_follows = current_user.followed_users.where(follows: { status: 'pending_follow' })
  end

  def set_follower_profiles
    @followers = current_user.following_users.where(follows: { status: 'accepted_follow' })
    @pending_followers = current_user.following_users.where(follows: { status: 'pending_follow' })
  end

  def profile_params
    params.require(:profile).permit(:name, :bio, :role)
  end
end
