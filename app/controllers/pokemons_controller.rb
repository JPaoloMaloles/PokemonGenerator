class PokemonsController < ApplicationController
  def show
    @pokemon = Pokemon.find_by(id: params["id"])
    render :show
  end

  def index
    @pokemons = Pokemon.all
    render :index
  end

  def create
    if current_user
      @pokemon = Pokemon.new(
        national_dex_num: params["national_dex_num"],
        name: params["name"],
        first_type: params["first_type"],
        second_type: params["second_type"],
        abilities: params["abilities"],
        hp: params["hp"],
        atk: params["atk"],
        defe: params["defe"],
        spa: params["spa"],
        spd: params["spd"],
        spe: params["spe"],
        url: params["url"],
        icon: params["icon"],
        first_type_image: params["first_type_image"],
        second_type_image: params["second_type_image"],
      )
      @pokemon.save
      render :show
    else
      render json: { message: "Not authorized user" }
    end
  end

  def update
    @pokemon = Pokemon.find_by(id: params["id"])
    @pokemon.update(
      national_dex_num: params["national_dex_num"] || params.national_dex_num,
      name: params["name"] || params.name,
      first_type: params["first_type"] || params.first_type,
      second_type: params["second_type"] || params.second_type,
      abilities: params["abilities"] || params.abilities,
      hp: params["hp"] || params.hp,
      atk: params["atk"] || params.atk,
      defe: params["defe"] || params.defe,
      spa: params["spa"] || params.spa,
      spd: params["spd"] || params.spd,
      spe: params["spe"] || params.spe,
      url: params["url"] || params.url,
      icon: params["icon"] || params.icon,
      first_type_image: params["first_type_image"] || params.first_type_image,
      second_type_image: params["second_type_image"] || params.second_type_image,
    )
    render :show
  end

  def destroy
    pokemon = Pokemon.find_by(id: params["id"])
    pokemon.destroy
    render json: { message: "pokemon has been deleted" }
  end
end
