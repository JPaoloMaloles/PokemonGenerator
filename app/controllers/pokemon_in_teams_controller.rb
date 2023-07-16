class PokemonInTeamsController < ApplicationController
  before_action :authenticate_user

  def show
    @pokemon_in_team = PokemonInTeam.find_by(id: params["id"])
    render :show
  end

  def index
    @pokemon_in_teams = PokemonInTeam.all
    render :index
  end

  def new
    @pokemon_in_team = PokemonInTeam.new
    render :new
  end

  def create
    @pokemon_in_team = PokemonInTeam.new(
      team_id: params[:pokemon_in_team][:team_id],
      unique_pokemon_id: params[:pokemon_in_team][:unique_pokemon_id],
    )
    if @pokemon_in_team.save
      redirect_to "/teams"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pokemon_in_team = PokemonInTeam.find_by(id: params[:id])
    render :edit
  end

  # def update
  #   @photo = Photo.find_by(id: params[:id])
  #   @photo.update(
  #     name: params[:photo][:name],
  #     width: params[:photo][:width],
  #     height: params[:photo][:height]
  #   )
  #   redirect_to "/photos"
  # end

  def update
    @pokemon_in_team = PokemonInTeam.find_by(id: params[:id])
    @pokemon_in_team.update(
      unique_pokemon_id: params[:pokemon_in_team][:unique_pokemon_id] || params.unique_pokemon_id,
    )
    redirect_to "/teams/#{@pokemon_in_team.team_id}"
  end

  # def destroy
  #   pokemon_in_team = PokemonInTeam.find_by(id: params["id"])
  #   pokemon_in_team.destroy
  #   render json: { message: "pokemon_in_team has been deleted" }
  # end

  def destroy
    @pokemon_in_team = PokemonInTeam.find_by(id: params["id"])
    team_id = @pokemon_in_team.team_id
    @pokemon_in_team.destroy

    redirect_to "/teams/#{team_id}", status: :see_other
  end
end
