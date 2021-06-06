class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @books_today = @user.books.where(created_at: Time.zone.now.all_day)
    @books_yesterday = @user.books.where(created_at: 1.day.ago.all_day)
    @books_2daysago = @user.books.where(created_at: 2.day.ago.all_day)
    @books_3daysago = @user.books.where(created_at: 3.day.ago.all_day)
    @books_4daysago = @user.books.where(created_at: 4.day.ago.all_day)
    @books_5daysago = @user.books.where(created_at: 5.day.ago.all_day)
    @books_6daysago = @user.books.where(created_at: 6.day.ago.all_day)
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books_thisweek = @user.books.where(created_at: from...to)
    @books_lastweek = @user.books.where(created_at: (from - 6.day)...(to - 6.day))
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
      render 'search'
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
      render 'search'
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
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
