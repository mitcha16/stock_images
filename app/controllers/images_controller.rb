class ImagesController < ApplicationController

  def index
    @images = Image.search(params[:search]) if params[:search]
  end
end
