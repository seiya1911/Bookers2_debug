# frozen_string_literal: true

class SearchsController < ApplicationController
  def search
    @range = params[:range]
    if @range == 'User'
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end

  def books_search
    @books = Book.looks(params[:search], params[:category])
    @book = Book.new
  end
end
