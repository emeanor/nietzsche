class BooksController < ApplicationController

  def show
    @book = Book.find_by(edition_id: params[:edition_id], position: params[:book_position] || params[:position])
  end

end