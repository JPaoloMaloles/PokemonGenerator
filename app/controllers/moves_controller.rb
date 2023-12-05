class MovesController < ApplicationController
  def show
    @move = Move.find_by(id: params["id"])
    render :show
  end

  def index
    @moves = Move.all
    render :index
  end
end
