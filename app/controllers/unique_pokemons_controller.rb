class UniquePokemonsController < ApplicationController
  def show
    @unique_pokemon = current_user.find_by(id: params["id"])
    render :show
  end

  def index
    @unique_pokemons = UniquePokemon.all #Unique_Pokemon.where(trainer_id: current.id)
    render :index
  end

  def create
    if current_user
      @unique_pokemon = UniquePokemon.new(
        nickname: params["nickname"],
        nature: params["nature"],
        gender: params["gender"],
        shiny: params["shiny"],
        ev: params["ev"],
        iv: params["iv"],
      )
      @unique_pokemon.save
      render :show
    else
      render json: { message: "Not authorized user" }
    end
  end

  def update
    @unique_pokemon = UniquePokemon.find_by(id: params["id"])
    @unique_pokemon.update(
      nickname: params["nickname"] || params.nickname,
      nature: params["nature"] || params.nature,
      gender: params["gender"] || params.gender,
      shiny: params["shiny"] || params.shiny,
      ev: params["ev"] || params.ev,
      iv: params["iv"] || params.iv,
    )
    render :show
  end

  def destroy
    unique_pokemon = UniquePokemon.find_by(id: params["id"])
    unique_pokemon.destroy
    render json: { message: "Unique_Pokemon has been deleted" }
  end
end
