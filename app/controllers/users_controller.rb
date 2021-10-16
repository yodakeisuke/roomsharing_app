class UsersController < ApplicationController

 skip_before_action :login_required,  only:[:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      flash[:notice] = "アカウントを新規登録しました"
      redirect_to root_url
    else
      render "new"
    end
  end

  def show_account
    @user = current_user
  end

  def edit_account
    @user = current_user
  end

  def update_account
    @user = current_user
    if @user.update(params.require(:user).permit(:email, :password, :password_confirmation))
      flash[:notice] = "アカウント情報を更新しました"
      redirect_to users_account_path
    else
      render :edit_account
    end
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = User.find(current_user.id)
    if @user.update(params.require(:user).permit(:name, :introduction, :image))
      flash[:notice] = "プロフィール情報を更新しました"
      redirect_to users_profile_path
    else
      render :edit_profile
    end
  end


end
