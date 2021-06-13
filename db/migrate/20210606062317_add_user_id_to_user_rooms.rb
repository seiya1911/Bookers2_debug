# frozen_string_literal: true

class AddUserIdToUserRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :user_rooms, :user_id, :integar
  end
end
