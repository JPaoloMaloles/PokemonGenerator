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
    ev_pool = 510
    ev_values = []
    6.times do
      ev_value = rand(0..ev_pool)
      ev_values << ev_value
      ev_pool = ev_pool - ev_value
    end
    ev_values = ev_values.shuffle

    @unique_pokemon = UniquePokemon.new(
      nickname: params[:unique_pokemon][:nickname],
      nature: params[:unique_pokemon][:nature], #model method, randomly choose from a list
      gender: "default", #model method, accounts of nil gender pokemon
      shiny: params[:unique_pokemon][:shiny], #model method, accurately represent shiny rate
      hp_ev: ev_values[0], #for presenting changed to rand, originally 0
      atk_ev: ev_values[1],
      defe_ev: ev_values[2],
      spa_ev: ev_values[3],
      spd_ev: ev_values[4],
      spe_ev: ev_values[5],
      hp_iv: rand(0..31), #dry with model method
      atk_iv: rand(0..31),
      defe_iv: rand(0..31),
      spa_iv: rand(0..31),
      spd_iv: rand(0..31),
      spe_iv: rand(0..31),
      trainer_id: current_user.current_trainer_id, #temporary,s withc to current_user's trainer
      pokemon_id: Pokemon.all.sample.id,
      level: rand(1..100),
    )
    @unique_pokemon.update(
      hp: @unique_pokemon.hp_calculation,
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
    @unique_pokemon = UniquePokemon.find_by(id: params["id"])
    @unique_pokemon.destroy
    redirect_to "/unique_pokemons"
  end

  def instant_create_unique_pokemon
    ev_pool = 510
    ev_values = []
    6.times do
      ev_value = rand(0..ev_pool)
      ev_values << ev_value
      ev_pool = ev_pool - ev_value
    end
    ev_values = ev_values.shuffle

    @unique_pokemon = UniquePokemon.new(
      nickname: params[:unique_pokemon][:nickname],
      nature: params[:unique_pokemon][:nature], #model method, randomly choose from a list
      gender: "default", #model method, accounts of nil gender pokemon
      shiny: params[:unique_pokemon][:shiny], #model method, accurately represent shiny rate
      hp_ev: ev_values[0], #for presenting changed to rand, originally 0
      atk_ev: ev_values[1],
      defe_ev: ev_values[2],
      spa_ev: ev_values[3],
      spd_ev: ev_values[4],
      spe_ev: ev_values[5],
      hp_iv: rand(0..31), #dry with model method
      atk_iv: rand(0..31),
      defe_iv: rand(0..31),
      spa_iv: rand(0..31),
      spd_iv: rand(0..31),
      spe_iv: rand(0..31),
      trainer_id: current_user.current_trainer_id, #temporary,s withc to current_user's trainer
      pokemon_id: Pokemon.all.sample.id,
      level: rand(1..100),
    )
    @unique_pokemon.save
    render :index
  end
end
