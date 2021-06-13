# frozen_string_literal: true

class CreateUserRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_rooms, &:timestamps
  end
end
