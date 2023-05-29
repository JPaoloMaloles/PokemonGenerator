# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Pokemon.create(
#   national_dex_num: "national_dex_num",
#   name: "name",
#   first_type: "first_type",
#   second_type: "second_type",
#   abilities: "abilities",
#   hp: 1,
#   atk: 1,
#   defe: 1,
#   spa: 1,
#   spd: 1,
#   spe: 1,
#   url: "url",
#   icon: "icon",
#   first_type_image: "first_type_image",
#   second_type_image: "second_type_image",
# )

require "httparty"
require "nokogiri"
multiword_ability = ["Air Lock", "Anger Point", "Anger Shell", "Arena Trap", "Armor Tail", "Aroma Veil", "As One", "Aura Break", "Bad Dreams", "Ball Fetch", "Battle Armor", "Battle Bond", "Beads of Ruin", "Beast Boost", "Big Pecks", "Cheek Pouch", "Chilling Neigh", "Clear Body", "Color Change", "Compoundeyes", "Cotton Down", "Cud Chew", "Curious Medicine", "Cursed Body", "Cute Charm", "Dark Aura", "Dauntless Shield", "Delta Stream", "Desolate Land", "Dragon's Maw", "Dry Skin", "Early Bird", "Earth Eater", "Effect Spore", "Electric Surge", "Emergency Exit", "Fairy Aura", "Flame Body", "Flame Boost", "Flash Fire", "Flower Gift", "Flower Veil", "Friend Guard", "Full Metal Body", "Fur Coat", "Gale Wings", "Good as Gold", "Gorilla Tactics", "Grass Pelt", "Grassy Surge", "Grim Neigh", "Guard Dog", "Gulp Missile", "Hadron Engine", "Heavy Metal", "Honey Gather", "Huge Power", "Hunger Switch", "Hyper Cutter", "Ice Body", "Ice Face", "Ice Scales", "Innards Out", "Inner Focus", "Intrepid Sword", "Iron Barbs", "Iron Fist", "Keen Eye", "Leaf Guard", "Light Metal", "Lightning Rod", "Lingering Aroma", "Liquid Ooze", "Liquid Voice", "Long Reach", "Magic Bounce", "Magic Guard", "Magma Armor", "Magnet Pull", "Marvel Scale", "Mega Launcher", "Mirror Armor", "Misty Surge", "Mold Breaker", "Motor Drive", "Mycelium Might", "Neutralizing Gas", "No Guard", "Orichalcum Pulse", "Own Tempo", "Parental Bond", "Pastel Veil", "Perish Body", "Poison Heal", "Poison Point", "Poison Touch", "Power Construct", "Power of Alchemy", "Power Spot", "Primordial Sea", "Prism Armor", "Propeller Tail", "Psychic Surge", "Punk Rock", "Pure Power", "Purifying Salt", "Quark Drive", "Queenly Majesty", "Quick Draw", "Quick Feet", "Rain Dish", "RKS System", "Rock Head", "Rocky Payload", "Rough Skin", "Run Away", "Sand Force", "Sand Rush", "Sand Spit", "Sand Stream", "Sand Veil", "Sap Sipper", "Screen Cleaner", "Seed Sower", "Serene Grace", "Shadow Shield", "Shadow Tag", "Sheer Force", "Shed Skin", "Shell Armor", "Shield Dust", "Shields Down", "Skill Link", "Slow Start", "Slush Rush", "Snow Cloack", "Snow Warning", "Solar Power", "Solid Rock", "Speed Boost", "Stance Change", "Steam Engine", "Steely Spirit", "Sticky Hold", "Storm Drain", "Strong Jaw", "Suction Cups", "Super Luck", "Surge Surfer", "Sweet Veil", "Swift Swim", "Sword of Ruin", "Tablets of Ruin", "Tangled Feet", "Tangling Hair", "Thermal Exchange", "Thick Fat", "Tinted Lens", "Tough Claws", "Toxic Boost", "Toxic Debris", "Unseen Fist", "Vessel of Ruin", "Victory Star", "Vital Spirit", "Volt Absorb", "Wandering Spirit", "Water Absorb", "Water Bubble", "Water Veil", "Weak Armor", "Well-Baked Body", "White Smoke", "Wimp Out", "Wind Power", "Wind Rider", "Wonder Guard", "Zen Mode", "Zero to Hero"]
response = HTTParty.get("https://www.serebii.net/pokemon/nationalpokedex.shtml")
document = Nokogiri::HTML(response.body)

PokemonProduct = Struct.new(:index, :national_dex_num, :name, :first_type, :second_type, :abilities, :hp, :atk, :defe, :spa, :spd, :spe, :url, :icon, :first_type_image, :second_type_image)
#national_dex_num, name, abilities, hp, atk, def, spa, spd, spe

html_products = document.css("table.dextable")
html_products = html_products.css("tr")

pokemon_products = []

pokemon_product_index = -2
html_products.each do |html_product|
  info = "#{html_product.css("td").text} "
  inforaw = html_product.css("td")
  img_check = inforaw.css("img")
  if !(info.inspect == "\" \"")
    puts "THIS IS ITERATION--------------------------------------------------------: #{pokemon_product_index}"
    info = []
    typeimage = []
    pokemon_product_index += 1

    #this code sets the :info attribute of PokemonProduct
    inforaw.each do |item|
      tempinfo = []
      clean_inspect = item.text.inspect.gsub("\\r\\n\\t", "")
      clean_inspect = clean_inspect.gsub("\\t", "")
      clean_inspect = clean_inspect.gsub!(/[^0-9A-Za-z\s]/, "")

      # puts "this is Clean_Inspect: #{clean_inspect}"
      tempinfo << clean_inspect
      # puts "This is tempinfo: #{tempinfo}"
      tempinfo.each do |item|
        if item.match?(/[0-9A-Za-z]/)
          # puts item
          multiword_ability.each do |ability|
            if item.include?(ability)
              item = item.gsub(ability, ability.gsub(" ", "_"))
            end
          end
          # if multiword_ability.include?(item)
          #   puts "THERES A SPACE"
          #   item = item.gsub(" ", "_")
          # end
          info << item
        end
      end
      # puts "AGAIN WE DO THIS: #{info}"
    end

    national_dex_num = info[0]
    name = info[1]
    abilities = info[2]
    hp = info[3]
    atk = info[4]
    defe = info[5]
    spa = info[6]
    spd = info[7]
    spe = info[8]

    images_url = inforaw.css("img")
    # puts images_url
    if !img_check.empty?
      url = "https://www.serebii.net" + html_product.css("a").first.attribute("href").value
      images_url.each do |image_url|
        #puts "This is image_url: #{image_url}"
        #puts "this is image_url.css: #{image_url.attribute("src").value}"
        typeimage << "https://www.serebii.net" + image_url.attribute("src").value
      end

      icon = typeimage[0]
      first_type_image = typeimage[1]
      second_type_image = typeimage[2]

      #--------- testing parsing out type from substring
      first_type_string = first_type_image.match(/(?<=type\/)(.*)(?=(.gif))/).to_s
      first_type = first_type_string

      if second_type_image
        second_type_string = second_type_image.match(/(?<=type\/)(.*)(?=(.gif))/).to_s
        second_type = second_type_string
      end
    end
    # puts "this is typeimage: #{typeimage.inspect}"
    # if !img_check.empty?
    #   url = "https://www.serebii.net" + html_product.css("a").first.attribute("href").value
    #   image = "https://www.serebii.net" + html_product.css("img").attribute("src").value
    #   image = "https://www.serebii.net" + html_product.css("img").attribute("src").value
    # end

    index = "#{pokemon_product_index}"
    pokemon_product = PokemonProduct.new(index, national_dex_num, name, first_type, second_type, abilities, hp, atk, defe, spa, spd, spe, url, icon, first_type_image, second_type_image)
    pokemon_products.push(pokemon_product)

    csv_headers = ["index", "national_dex_num", "name", "first_type", "second_type", "abilities", "hp", "atk", "defe", "spa", "spd", "spe", "url", "icon", "first_type_image", "second_type_image"]
    CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
      pokemon_products.each do |pokemon_product|
        csv << pokemon_product
      end
    end
  end
end

attribute_titles = ["national_dex_num", "name", "first_type", "second_type", "abilities", "hp", "atk", "defe", "spa", "spd", "spe", "url", "icon", "first_type_image", "second_type_image"]
pokemon_array = []
count = 0
pokemon_products.each do |pokemon|
  single_pokemon = {}
  count = 0
  if pokemon.index.to_i > 0 #just for getting a clean list, we can do this in validations later
    while count < attribute_titles.length
      single_pokemon[attribute_titles[count].to_sym] = pokemon[count + 1]
      count += 1
    end
    # puts single_pokemon
    pokemon_array << single_pokemon
  end
end
# pp pokemon_array[0]
count = 1
pokemon_array.each do |pokemon|
  puts "creating pokemon model ##{count}"
  Pokemon.create(pokemon)
  count += 1
end
# return pokemon_array

#Assigns two UniquePokemon to a Team through PokemonInTeam
User.create!(name: "name", email: "email@gmail.com", password: "password", password_confirmation: "password", admin: true)
Trainer.create!(title: "example title", level: 1, experience: 0, user_id: 1)
Team.create!(trainer_id: 1, name: "ExampleTeam")
UniquePokemon.create!(nickname: "a", gender: "gender", shiny: true, nature: "nature", hp_ev: 0, atk_ev: 0, defe_ev: 0, spa_ev: 0, spd_ev: 0, spe_ev: 0, hp_iv: 0, atk_iv: 0, defe_iv: 0, spa_iv: 0, spd_iv: 0, spe_iv: 0, pokemon_id: 1)
UniquePokemon.create!(nickname: "a", gender: "gender", shiny: true, nature: "nature", hp_ev: 0, atk_ev: 0, defe_ev: 0, spa_ev: 0, spd_ev: 0, spe_ev: 0, hp_iv: 0, atk_iv: 0, defe_iv: 0, spa_iv: 0, spd_iv: 0, spe_iv: 0, pokemon_id: 2)
PokemonInTeam.create!(team_id: 1, unique_pokemon_id: 1)
PokemonInTeam.create!(team_id: 1, unique_pokemon_id: 2)
#Creates another team and assigns the first UniquePokemon to it
Team.create!(trainer_id: 1, name: "ExampleTeam2")
PokemonInTeam.create!(team_id: 2, unique_pokemon_id: 1)

# json.name trainer.name
# json.title trainer.title
# json.level trainer.level
# json.experience trainer.experience
# json.user_id trainer.user_id
