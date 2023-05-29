class PokemonInTeamsController < ApplicationController
  def show
    @pokemon_in_team = PokemonInTeam.find_by(id: params["id"])
    render :show
  end

  def index
    @pokemon_in_teams = PokemonInTeam.all
    render :index
  end

  def create
    if current_user
      @pokemon_in_team = PokemonInTeam.new(
        team_id: params["team_id"],
        unique_pokemon_id: params["unique_pokemon_id"],
      )
      @pokemon_in_team.save
      render :show
    else
      render json: { message: "Not authorized user" }
    end
  end

  def update
    @pokemon_in_team = PokemonInTeam.find_by(id: params["id"])
    @pokemon_in_team.update(
      team_id: params["team_id"] || params.team_id,
      unique_pokemon_id: params["unique_pokemon_id"] || params.unique_pokemon_id,
    )
    render :show
  end

  def destroy
    pokemon_in_team = PokemonInTeam.find_by(id: params["id"])
    pokemon_in_team.destroy
    render json: { message: "pokemon_in_team has been deleted" }
  end
end
