class ChaptersController < ApplicationController

  def show
    book = Book.find_by(edition_id: params[:edition_id], position: params[:book_position] || params[:position])
    @chapter = Chapter.includes(:chapter_texts).find_by(book_id: book.id, position: params[:position])
  end

end