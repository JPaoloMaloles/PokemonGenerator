class MovesetsController < ApplicationController
  def show
    @moveset = Moveset.find_by(id: params["id"])
    render :show
  end

  def index
    @movesets = Moveset.all
    render :index
  end
end
