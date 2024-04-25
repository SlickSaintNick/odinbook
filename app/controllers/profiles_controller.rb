class ProfilesController < ApplicationController
  def new
    @profile = current_user.create_profile
  end

  def edit
    @profile = current_user.profile
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
    if @profile.update(article_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :bio, :role)
  end
end
