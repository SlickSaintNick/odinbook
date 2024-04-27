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

  def find_profile_groups
    @follow_requests = current_user.following_users.where(follows: { status: 'pending_follow' })
    @followers = current_user.following_users.where(follows: { status: 'accepted_follow' })

    @pending_follows = current_user.followed_users.where(follows: { status: 'pending_follow' })
    @following = current_user.followed_users.where(follows: { status: 'accepted_follow' })

    @not_following = find_not_following(@pending_follows)
  end

  def find_not_following(pending_follows)
    (User.where.not(id: (current_user.following_user_ids + [current_user.id])) + pending_follows).uniq
  end

  def profile_params
    params.require(:profile).permit(:name, :bio, :role, :profile_image)
  end
end
