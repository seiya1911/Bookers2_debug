# frozen_string_literal: true

class AddRoomIdToUserRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :user_rooms, :room_id, :integar
  end
end
