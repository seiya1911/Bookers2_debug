# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(searches, words)
    if searches == 'perfect_match'
      @book = Book.where('title LIKE ?', words.to_s)
    elsif searches == 'prefix_match'
      @user = Book.where('title LIKE ?', "#{words}%")
    elsif searches == 'backword_match'
      @user = Book.where('title LIKE ?', "%#{words}")
    else
      @book = Book.where('title LIKE ?', "%#{words}%")
    end
  end

  is_impressionable counter_cache: true
end
