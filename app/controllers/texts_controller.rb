class TextsController < ApplicationController

  def index
    @texts = Text.all.order(:nietzsche_number)
  end

  def show
    @text = Text.find_by(url_slug: params[:url_slug])
  end

end