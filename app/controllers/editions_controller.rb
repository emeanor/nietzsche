class EditionsController < ApplicationController

  def index
    @editions = Edition.all.order(updated_at: :desc).includes(:user)
  end

  def show
    @edition = Edition.find(params[:id] || params[:edition_id])
  end

end