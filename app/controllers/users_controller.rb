class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    # 追加してみた
    @currentUserMember = Member.where(user_id: current_user.id)
    @userMember = Member.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserMember.each do |cu|
        @userMember.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @member = Member.new
      end
    end
    # ここまで
    @books = @user.books
    @book = Book.new
    @booksToday = @user.books.where("created_at >= ?", Date.today)
    # @booksTesterday = @user.books.where("created_at >= ?", Date.yesterday)
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @booksThisweek = @user.books.where(created_at: from...to)
    @booksLastweek = @user.books.where(created_at: (from - 6.day)...(to - 6.day))
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
