class ChaptersController < ApplicationController

  def show
    book = Edition.find(params[:edition_id]).books.find_by(position: params[:book_position] || params[:position])
    @chapter = Chapter.includes(:chapter_texts).find_by(book_id: book.id, position: params[:position])
  end

end