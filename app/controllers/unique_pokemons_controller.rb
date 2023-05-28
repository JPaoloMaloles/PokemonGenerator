class UniquePokemonsController < ApplicationController
  def show
    @unique_pokemon = current_user.find_by(id: params["id"])
    render :show
  end

  def index
    @unique_pokemons = UniquePokemon.all #Unique_Pokemon.where(trainer_id: current.id)
    render :index
  end

  def create #-------------------------------- need to include level, experience, ability (taken from Pokemon model)
    if current_user
      @unique_pokemon = UniquePokemon.new(
        nickname: params["nickname"],
        nature: params["nature"], #model method, randomly choose from a list
        gender: rand(1..2), #model method, accounts of nil gender pokemon
        shiny: params["shiny"], #model method, accurately represent shiny rate
        hp_ev: 0,
        atk_ev: 0,
        defe_ev: 0,
        spa_ev: 0,
        spd_ev: 0,
        spe_ev: 0,
        hp_iv: rand(0..31),
        atk_iv: rand(0..31),
        defe_iv: rand(0..31),
        spa_iv: rand(0..31),
        spd_iv: rand(0..31),
        spe_iv: rand(0..31),
        user_id: nil,
        pokemon_id: rand(1..Pokemon.count),
      )
      @unique_pokemon.save
      render :show
    else
      render json: { message: "Not authorized user" }
    end
  end

  def admin_create
    if current_user && current_user.admin
      @unique_pokemon = UniquePokemon.new(
        nickname: params["nickname"],
        nature: params["nature"],
        gender: params["gender"],
        shiny: params["shiny"],
        hp_ev: params["hp_ev"],
        atk_ev: params["atk_ev"],
        defe_ev: params["defe_ev"],
        spa_ev: params["spa_ev"],
        spd_ev: params["spd_ev"],
        spe_ev: params["spe_ev"],
        hp_iv: params["hp_iv"],
        atk_iv: params["atk_iv"],
        defe_iv: params["defe_iv"],
        spa_iv: params["spa_iv"],
        spd_iv: params["spd_iv"],
        spe_iv: params["spe_iv"],
        user_id: params["user_id"],
        pokemon_id: params["pokemon_id"],
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
      hp_ev: params["hp_ev"] || params.hp_ev,
      atk_ev: params["atk_ev"] || params.atk_ev,
      defe_ev: params["defe_ev"] || params.defe_ev,
      spa_ev: params["spa_ev"] || params.spa_ev,
      spd_ev: params["spd_ev"] || params.spd_ev,
      spe_ev: params["spe_ev"] || params.spe_ev,
      hp_iv: params["hp_iv"] || params.hp_iv,
      atk_iv: params["atk_iv"] || params.atk_iv,
      defe_iv: params["defe_iv"] || params.defe_iv,
      spa_iv: params["spa_iv"] || params.spa_iv,
      spd_iv: params["spd_iv"] || params.spd_iv,
      spe_iv: params["spe_iv"] || params.spe_iv,
      user_id: current_user.id,
    )
    render :show
  end

  def destroy
    unique_pokemon = UniquePokemon.find_by(id: params["id"])
    unique_pokemon.destroy
    render json: { message: "Unique_Pokemon has been deleted" }
  end
end
