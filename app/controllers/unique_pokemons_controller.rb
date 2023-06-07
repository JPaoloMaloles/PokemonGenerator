class UniquePokemonsController < ApplicationController
  before_action :authenticate_user

  def show
    unique_pokemon = current_user.unique_pokemons.find_by(id: params["id"])
    if unique_pokemon
      @unique_pokemon = unique_pokemon
      render :show
    else
      render json: [], status: :unauthorized
    end
  end

  def index
    #@unique_pokemons = UniquePokemon.where(user_id: current_user.id)
    @unique_pokemons = current_user.unique_pokemons
    render :index
  end

  def new
    @unique_pokemon = UniquePokemon.new
    render :new
  end

  def create #-------------------------------- need to include level, experience, ability (taken from Pokemon model)
    @unique_pokemon = UniquePokemon.new(
      nickname: params[:unique_pokemon][:nickname],
      nature: params[:unique_pokemon][:nature], #model method, randomly choose from a list
      gender: "default", #model method, accounts of nil gender pokemon
      shiny: params[:unique_pokemon][:shiny], #model method, accurately represent shiny rate
      hp_ev: rand(0..252), #for presenting changed to rand, originally 0
      atk_ev: rand(0..252),
      defe_ev: rand(0..252),
      spa_ev: rand(0..252),
      spd_ev: rand(0..252),
      spe_ev: rand(0..252),
      hp_iv: rand(0..31), #dry with model method
      atk_iv: rand(0..31),
      defe_iv: rand(0..31),
      spa_iv: rand(0..31),
      spd_iv: rand(0..31),
      spe_iv: rand(0..31),
      user_id: current_user.id,
      pokemon_id: Pokemon.all.sample.id,
    )
    @unique_pokemon.save
    redirect_to "/unique_pokemons/#{@unique_pokemon.id}"
  end

  def admin_create
    if current_user && current_user.admin
      @unique_pokemon = UniquePokemon.new(
        nickname: params[:unique_pokemon]["nickname"],
        nature: params[:unique_pokemon]["nature"],
        gender: params[:unique_pokemon]["gender"],
        shiny: params[:unique_pokemon]["shiny"],
        hp_ev: params[:unique_pokemon]["hp_ev"],
        atk_ev: params[:unique_pokemon]["atk_ev"],
        defe_ev: params[:unique_pokemon]["defe_ev"],
        spa_ev: params[:unique_pokemon]["spa_ev"],
        spd_ev: params[:unique_pokemon]["spd_ev"],
        spe_ev: params[:unique_pokemon]["spe_ev"],
        hp_iv: params[:unique_pokemon]["hp_iv"],
        atk_iv: params[:unique_pokemon]["atk_iv"],
        defe_iv: params[:unique_pokemon]["defe_iv"],
        spa_iv: params[:unique_pokemon]["spa_iv"],
        spd_iv: params[:unique_pokemon]["spd_iv"],
        spe_iv: params[:unique_pokemon]["spe_iv"],
        user_id: params[:unique_pokemon]["user_id"],
        pokemon_id: params[:unique_pokemon]["pokemon_id"],
      )
      @unique_pokemon.save
      render :show
    else
      render json: { message: "Not authorized user" }
    end
  end

  def edit
    @unique_pokemon = UniquePokemon.find_by(id: params[:id])
    render :edit
  end

  def update
    @unique_pokemon = UniquePokemon.find_by(id: params["id"])
    @unique_pokemon.update(
      nickname: params[:unique_pokemon]["nickname"],
      # nature: params["nature"] || params.nature,
      # gender: params["gender"] || params.gender,
      # shiny: params["shiny"] || params.shiny,
      # hp_ev: params["hp_ev"] || params.hp_ev,
      # atk_ev: params["atk_ev"] || params.atk_ev,
      # defe_ev: params["defe_ev"] || params.defe_ev,
      # spa_ev: params["spa_ev"] || params.spa_ev,
      # spd_ev: params["spd_ev"] || params.spd_ev,
      # spe_ev: params["spe_ev"] || params.spe_ev,
      # hp_iv: params["hp_iv"] || params.hp_iv,
      # atk_iv: params["atk_iv"] || params.atk_iv,
      # defe_iv: params["defe_iv"] || params.defe_iv,
      # spa_iv: params["spa_iv"] || params.spa_iv,
      # spd_iv: params["spd_iv"] || params.spd_iv,
      # spe_iv: params["spe_iv"] || params.spe_iv,
      user_id: current_user.id,
    )
    redirect_to "/unique_pokemons"
  end

  def admin_update
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
      user_id: params["user_id"] || params.user_id,
    )
    render :show
  end

  def destroy
    unique_pokemon = UniquePokemon.find_by(id: params["id"])
    unique_pokemon.destroy
    render json: { message: "Unique_Pokemon has been deleted" }
  end
end
