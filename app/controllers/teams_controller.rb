class TeamsController < ApplicationController
  before_action :authenticate_user
  
  def show
    @team = Team.find_by(id: params["id"])
    render :show
  end

  def index
    @teams = Team.all
    render :index
  end

  def create
    @team = Team.new(
      trainer_id: params["trainer_id"],
      name: params["name"],
    )
    @team.save
    render :show
  end

  def update
    @team = Team.find_by(id: params["id"])
    @team.update(
      trainer_id: params["trainer_id"] || params.trainer_id,
      name: params["name"] || params.name,
    )
    render :show
  end

  def destroy
    team = Team.find_by(id: params["id"])
    team.destroy
    render json: { message: "Team has been deleted" }
  end
end
