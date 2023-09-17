class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @following_users = @user.following_users
    @follower_users = @user.follower_users
    @today_book =  @books.created_today
    @yesterday_book = @books.created_yesterday
    @the_day_before =   @today_book.count / @yesterday_book.count.to_f #小数点で出す
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    @the_week_before = @this_week_book.count / @last_week_book.count.to_f #小数点で出す
    # 配列を用意して冊数を入れていく
    @read_nums = {}
    (0..6).reverse_each do |num|
      if num == 0
        num_str = "今日"
      else
        num_str = num.to_s + "日前"
      end

      @read_nums[num_str] = @books.where(created_at: num.day.ago.all_day).count
    end

  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  # フォロー一覧
  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @users = user.follower_users
  end


  def search

    @user = User.find(params[:id])
    @books = @user.books

    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end


end
