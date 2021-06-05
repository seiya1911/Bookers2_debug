class Room < ApplicationRecord
  has_many :members
  has_many :chats
end
