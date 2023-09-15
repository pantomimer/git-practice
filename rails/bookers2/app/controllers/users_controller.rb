class UsersController < ApplicationController

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end

  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end


  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end


end
