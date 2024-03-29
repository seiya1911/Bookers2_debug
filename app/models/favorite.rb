# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :book_id, uniqueness: { scope: :user_id }
end
