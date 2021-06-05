class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    @member1 = Member.create(room_id: @room.id, user_id: current_user.id)
    @member2 = Member.create(params.require(:member).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    if Member.where(user_id: current_user.id,room_id: @room.id).present?
      @chats = @room.chats
      @chat = Chat.new
      @members = @room.members
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
