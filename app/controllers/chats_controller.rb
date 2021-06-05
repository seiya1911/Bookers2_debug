class ChatsController < ApplicationController
  # def show
  #   @user = User.find(params[:id])
  #   rooms = current_user.member.pluck(:room_id)
  #   members = Member.find_by(user_id: @user.id, room_id: rooms)

  #   unless member.nil?
  #     @room = members.room
  #   else
  #     @room = Room.new
  #     @room.save
  #     Member.create(user_id: current_user.id, room_id: @room.id)
  #     Member.create(user_id: @user.id, room_id: @room.id)
  #   end
  #   @chats = @room.chats
  #   @chat = Chat.new(room_id: @room.id)
  # end

  # def create
  #   @chat = current_user.chats.new(chat_params)
  #   @chat.save
  #   redirect_to request.referer
  # end

  # private
  # def chat_params
  #   params.require(:chat).permit(:message, :room_id)
  # end
  before_action :authenticate_user!, only: [:create]

  def create
    if Member.where(user_id: current_user.id, room_id: params[:chat][:room_id]).present?
      @chat = chat.create(params.require(:chat).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
　　redirect_to "/rooms/#{@chat.room_id}"
  end
end
