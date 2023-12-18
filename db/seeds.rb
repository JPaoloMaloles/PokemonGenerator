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
multiword_ability = ["Air Lock", "Anger Point", "Anger Shell", "Arena Trap", "Armor Tail", "Aroma Veil", "As One", "Aura Break", "Bad Dreams", "Ball Fetch", "Battle Armor", "Battle Bond", "Beads of Ruin", "Beast Boost", "Big Pecks", "Cheek Pouch", "Chilling Neigh", "Clear Body", "Color Change", "Compoundeyes", "Cotton Down", "Cud Chew", "Curious Medicine", "Cursed Body", "Cute Charm", "Dark Aura", "Dauntless Shield", "Delta Stream", "Desolate Land", "Dragon's Maw", "Dry Skin", "Early Bird", "Earth Eater", "Effect Spore", "Electric Surge", "Emergency Exit", "Fairy Aura", "Flame Body", "Flame Boost", "Flash Fire", "Flower Gift", "Flower Veil", "Friend Guard", "Full Metal Body", "Fur Coat", "Gale Wings", "Good as Gold", "Gorilla Tactics", "Grass Pelt", "Grassy Surge", "Grim Neigh", "Guard Dog", "Gulp Missile", "Hadron Engine", "Heavy Metal", "Honey Gather", "Huge Power", "Hunger Switch", "Hyper Cutter", "Ice Body", "Ice Face", "Ice Scales", "Innards Out", "Inner Focus", "Intrepid Sword", "Iron Barbs", "Iron Fist", "Keen Eye", "Leaf Guard", "Light Metal", "Lightning Rod", "Lingering Aroma", "Liquid Ooze", "Liquid Voice", "Long Reach", "Magic Bounce", "Magic Guard", "Magma Armor", "Magnet Pull", "Marvel Scale", "Mega Launcher", "Mirror Armor", "Misty Surge", "Mold Breaker", "Motor Drive", "Mycelium Might", "Natural Cure", "Neutralizing Gas", "No Guard", "Orichalcum Pulse", "Own Tempo", "Parental Bond", "Pastel Veil", "Perish Body", "Poison Heal", "Poison Point", "Poison Touch", "Power Construct", "Power of Alchemy", "Power Spot", "Primordial Sea", "Prism Armor", "Propeller Tail", "Psychic Surge", "Punk Rock", "Pure Power", "Purifying Salt", "Quark Drive", "Queenly Majesty", "Quick Draw", "Quick Feet", "Rain Dish", "RKS System", "Rock Head", "Rocky Payload", "Rough Skin", "Run Away", "Sand Force", "Sand Rush", "Sand Spit", "Sand Stream", "Sand Veil", "Sap Sipper", "Screen Cleaner", "Seed Sower", "Serene Grace", "Shadow Shield", "Shadow Tag", "Sheer Force", "Shed Skin", "Shell Armor", "Shield Dust", "Shields Down", "Skill Link", "Slow Start", "Slush Rush", "Snow Cloack", "Snow Warning", "Solar Power", "Solid Rock", "Speed Boost", "Stance Change", "Steam Engine", "Steely Spirit", "Sticky Hold", "Storm Drain", "Strong Jaw", "Suction Cups", "Super Luck", "Surge Surfer", "Sweet Veil", "Swift Swim", "Sword of Ruin", "Tablets of Ruin", "Tangled Feet", "Tangling Hair", "Thermal Exchange", "Thick Fat", "Tinted Lens", "Tough Claws", "Toxic Boost", "Toxic Debris", "Unseen Fist", "Vessel of Ruin", "Victory Star", "Vital Spirit", "Volt Absorb", "Wandering Spirit", "Water Absorb", "Water Bubble", "Water Veil", "Weak Armor", "Well-Baked Body", "White Smoke", "Wimp Out", "Wind Power", "Wind Rider", "Wonder Guard", "Wonder Skin", "Zen Mode", "Zero to Hero"]
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
      clean_inspect = clean_inspect.gsub!(/[^0-9A-Za-z\s-]/, "")

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
Trainer.create!(name: "example name", title: "example title", level: 1, experience: 0, user_id: 1)
User.update(current_trainer_id: Trainer.last.id)
Team.create!(trainer_id: 1, name: "ExampleTeam")
UniquePokemon.create!(nickname: "a", gender: "gender", shiny: true, nature: "nature", hp_ev: 0, atk_ev: 0, defe_ev: 0, spa_ev: 0, spd_ev: 0, spe_ev: 0, hp_iv: 0, atk_iv: 0, defe_iv: 0, spa_iv: 0, spd_iv: 0, spe_iv: 0, pokemon_id: 1, trainer_id: 1, level: 100, hp: 1, atk: 1, defe: 1, spa: 1, spd: 1, spe: 1, ability: "test1")
UniquePokemon.create!(nickname: "a", gender: "gender", shiny: true, nature: "nature", hp_ev: 0, atk_ev: 0, defe_ev: 0, spa_ev: 0, spd_ev: 0, spe_ev: 0, hp_iv: 0, atk_iv: 0, defe_iv: 0, spa_iv: 0, spd_iv: 0, spe_iv: 0, pokemon_id: 2, trainer_id: 1, level: 100, hp: 2, atk: 2, defe: 2, spa: 2, spd: 2, spe: 2, ability: "test2")
PokemonInTeam.create!(team_id: 1, unique_pokemon_id: 1)
PokemonInTeam.create!(team_id: 1, unique_pokemon_id: 2)
#Creates another team and assigns the first UniquePokemon to it
Team.create!(trainer_id: 1, name: "ExampleTeam2")

# UniquePokemon.create!(nickname: "a", gender: "gender", shiny: true, nature: "nature", hp_ev: 0, atk_ev: 0, defe_ev: 0, spa_ev: 0, spd_ev: 0, spe_ev: 0, hp_iv: 0, atk_iv: 0, defe_iv: 0, spa_iv: 0, spd_iv: 0, spe_iv: 0, pokemon_id: 2, user_id: 2)

# json.name trainer.name
# json.title trainer.title
# json.level trainer.level
# json.experience trainer.experience
# json.user_id trainer.user_id





url_paths = ["pokeball","holditem","evolutionary","berry","vitamins","fossil","miscellaneous",]

# pokemon_product_index = -1
# pokemon_products = []

# ItemProduct = Struct.new(:index, :image, :name, :effect)

# url_paths.each do |url_path|
#   response = HTTParty.get("https://www.serebii.net/itemdex/list/#{url_path}.shtml")

#   document = Nokogiri::HTML(response.body)

#   #national_dex_num, name, abilities, hp, atk, def, spa, spd, spe

#   html_products = document.css("table.dextable")
#   html_products = html_products.css("tr")


#   html_products.each do |html_product|
#     info = "#{html_product.css("td").text} "
#     inforaw = html_product.css("td")
#     img_check = inforaw.css("img")

#     if !(info.inspect == "\" \"")
#       puts "THIS IS ITERATION--------------------------------------------------------: #{pokemon_product_index}"
#       info = []
#       typeimage = []
#       pokemon_product_index += 1

#       #this code sets the :info attribute of PokemonProduct
#       inforaw.each do |item|
#         tempinfo = []
#         clean_inspect = item.text.inspect.gsub("\\r\\n\\t", "")
#         clean_inspect = clean_inspect.gsub("\\t", "")
#         clean_inspect = clean_inspect.gsub!(/[^0-9A-Za-z.,—\s-]/, "")

#         # puts "this is Clean_Inspect: #{clean_inspect}"
#         tempinfo << clean_inspect
#         # puts "This is tempinfo: #{tempinfo}"
#         tempinfo.each do |item|
#           if item.match?(/[0-9A-Za-z]/)
#             # puts "IT WORKS"
#             info << item
#           end
#         end
#         # puts "AGAIN WE DO THIS: #{info}"
#       end
    
#       name = info[0]

#       if info[1]
#         # puts "info1 is #{info[1]}"
#         description = info[1].gsub!("Pok", "Poke") || info[1]
#         # puts description
#       end


#       # puts images_url
#       item_image = ""
#       if !img_check.empty?
#         item_image = "https://www.serebii.net" + inforaw.css("img").attribute("src").value
#       end

#       # p item_image
#       # p name
#       # p description

#       if name != "Picture"
#         pokemon_product = ItemProduct.new(pokemon_product_index, item_image, name, description)
#         pokemon_products.push(pokemon_product)
#       else
#         pokemon_product_index += -1
#       end

#     end
#   end
# end


# csv_headers = ["index", "image", "name", "effect"]
# CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
#   pokemon_products.each do |pokemon_product|
#     csv << pokemon_product
#   end
# end

# attribute_titles = ["image", "name", "effect"]
# item_array = []
# count = 0
# pokemon_products.each do |item|
#   single_item = {}
#   count = 0
#   if item.index.to_i > 0 #just for getting a clean list, we can do this in validations later
#     while count < attribute_titles.length
#       single_item[attribute_titles[count].to_sym] = item[count + 1]
#       count += 1
#     end
#     # puts single_item
#     item_array << single_item
#   end
# end
# # pp item_array[0]
# count = 1
# item_array.each do |item|
#   puts "creating item model ##{count}"
#   Item.create(item)
#   count += 1
# end











url_paths = ["physical","special", "other"]

pokemon_product_index = -1
pokemon_products = []

MoveProduct = Struct.new(:index, :name, :type, :category, :pp, :power, :accuracy, :effect_percent, :description)

url_paths.each do |url_path|
  response = HTTParty.get("https://www.serebii.net/attackdex-sv/#{url_path}.shtml")

  document = Nokogiri::HTML(response.body)

  #national_dex_num, name, abilities, hp, atk, def, spa, spd, spe

  html_products = document.css("table.dextable")
  html_products = html_products.css("tr")


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
        clean_inspect = clean_inspect.gsub!(/[^0-9A-Za-z.,—\s-]/, "")

        # puts "this is Clean_Inspect: #{clean_inspect}"
        tempinfo << clean_inspect
        puts "This is tempinfo: #{tempinfo}"
        tempinfo.each do |item|
          if item.match?(/[0-9A-Za-z-]/)
            # puts "IT WORKS"
            info << item
          end
        end
        # puts "AGAIN WE DO THIS: #{info}"
      end
    
      pp "info is #{info}"
      name = info[0]
      category = url_path
      power_points = info[1]
      power = info[2]
      accuracy = info[3]

      if info[4]
        puts "info1 is #{info[4]}"
        description = info[4].gsub!("Pok", "Poke") || info[4]
        # puts description
      end

      images_url = inforaw.css("img")
      # puts images_url
      item_image = ""
      if !img_check.empty?
        item_image = "https://www.serebii.net" + inforaw.css("img").attribute("src").value
        url = "https://www.serebii.net" + html_product.css("a").first.attribute("href").value
      images_url.each do |image_url|
        #puts "This is image_url: #{image_url}"
        #puts "this is image_url.css: #{image_url.attribute("src").value}"
        typeimage << "https://www.serebii.net" + image_url.attribute("src").value
      end

      pp "typeimage is #{typeimage}"
      icon = typeimage[0]
      first_type_image = typeimage[0]
      second_type_image = typeimage[1]

      #--------- testing parsing out type from substring
      first_type_string = first_type_image.match(/(?<=type\/)(.*)(?=(.gif))/).to_s
      type = first_type_string

      if second_type_image
        second_type_string = second_type_image.match(/(?<=type\/)(.*)(?=(.gif))/).to_s
        second_type = second_type_string
      end
      end

      # p item_image
      # p name
      # p description

      if name != "rnNamern"
        # MoveProduct = Struct.new(:index, :name, :type, :category, :pp, :power, :accuracy,)
        pokemon_product = MoveProduct.new(pokemon_product_index, name, type, category, power_points, power, accuracy, description)
        pokemon_products.push(pokemon_product)
      else
        pokemon_product_index += -1
      end

    end
  end
end


csv_headers = ["index", "name", "type", "category", "pp", "power", "accuracy", "description"]
CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
  pokemon_products.each do |pokemon_product|
    csv << pokemon_product
  end
end

attribute_titles = ["name", "move_type", "category", "pp", "power", "accuracy", "description"]
move_array = []
count = 0
pokemon_products.each do |move|
  single_move = {}
  count = 0
  if move.index.to_i > 0 #just for getting a clean list, we can do this in validations later
    while count < attribute_titles.length
      single_move[attribute_titles[count].to_sym] = move[count + 1]
      count += 1
    end
    # puts single_move
    move_array << single_move
  end
end
# pp move_array[0]
count = 1
move_array.each do |move|
  puts "creating move model ##{count}"
  Move.create(move)
  count += 1
end








games = ["pokedex-sv"]
MovesetProduct = Struct.new(:index, :level_acquire, :name, :type, :category, :pp, :power, :accuracy, :effect_percent, :description)

all_pokemons = Pokemon.where("LENGTH(name) > 1")
puts "length of allpokemons: #{all_pokemons.length}"
all_pokemons.each do |pokemon_model|
  pokemon_target = pokemon_model.name.downcase.gsub(" ", "")
  puts "Pokemon target is #{pokemon_target}"
  

  is_move = false
  is_egg_move = false
  is_preev_move = false
  is_over = false
  needs_description = false

  level_acquire = ""
  name = ""
  type_string = ""
  category_string = ""
  power_points = ""
  power = ""
  accuracy = ""
  effect_percent = ""
  description = ""

  if pokemon_target == "charizard"
    break
  end

  pokemon_product_index = -1
  pokemon_products = []

  games.each do |game|
    response = HTTParty.get("https://www.serebii.net/#{game}/#{pokemon_target}/")
    document = Nokogiri::HTML(response.body)
    puts "working on https://www.serebii.net/#{game}/#{pokemon_target}/"

    if document.title != "404 Error"
      html_products = document.css("table.dextable")
      html_products = html_products.css("tr")
      # puts "working on https://www.serebii.net/#{game}/#{pokemon_target}/"

      html_products.each do |html_product|
        info = "#{html_product.css("td").text} "
        inforaw = html_product.css("td")
        img_check = inforaw.css("img")

        if !(info.inspect == "\" \"")
          puts "#{pokemon_target} --------------------------------------------------------: #{pokemon_product_index}"
          puts "needs_description is #{needs_description}"
          if needs_description == false
            info = []
          end
          typeimage = []
          pokemon_product_index += 1

          #this code sets the :info attribute of PokemonProduct
          if is_over == false
            inforaw.each do |item|
              tempinfo = []
              clean_inspect = item.text.inspect.gsub("\\r\\n\\t", "")
              clean_inspect = clean_inspect.gsub("\\t", "")
              clean_inspect = clean_inspect.gsub!(/[^0-9A-Za-z.,—?\s-]/, "")

              # puts "this is Clean_Inspect: #{clean_inspect}"
              tempinfo << clean_inspect
              puts "This is tempinfo: #{tempinfo}"
              if tempinfo[0] == "Standard Level Up"
                is_move = true
              elsif tempinfo[0] == "Stats"
                is_move = false
                is_egg_move = false
                is_preev_move = false
                is_over = true
              elsif tempinfo[0] == "Egg Moves Details"
                is_egg_move = true
              elsif tempinfo[0] == "Pre-Evolution Only Moves"
                is_preev_move = true
                is_egg_move = false
              end 

              if is_move == true
                tempinfo.each do |item|
                  if item.match?(/[0-9A-Za-z—? -]/)
                    # puts "IT WORKS"
                    info << item
                  end
                end
              end
              # puts "AGAIN WE DO THIS: #{info}"
            end
          

            # pp "info is #{info}"
            # pp "info1 -------------#{info[1]}"
            if needs_description == false
              if is_egg_move == false && is_preev_move == false
                level_acquire = info[0]
                name = info[1]
                power = info[2]
                accuracy = info[3]
                power_points = info[4]
                effect_percent = info[5]
              elsif is_egg_move == true
                level_acquire = "Egg"
                name = info[0]
                power = info[1]
                accuracy = info[2]
                power_points = info[3]
                effect_percent = info[4]
              elsif is_preev_move == true
                level_acquire = "Pre-Evolution"
                name = info[0]
                power = info[3]
                accuracy = info[4]
                power_points = info[5]
                effect_percent = info[6]
              end
            else
              description = info
            end

            if is_move == true && info[1]
              img_check = inforaw.css("img")
              # puts img_check
              if !img_check.empty?
                url = "https://www.serebii.net" + html_product.css("a").first.attribute("href").value
                img_check.each do |image_url|
                  #puts "This is image_url: #{image_url}"
                  #puts "this is image_url.css: #{image_url.attribute("src").value}"
                  typeimage << "https://www.serebii.net" + image_url.attribute("src").value
                end

                p "Type image is #{typeimage}"
                type_url = typeimage[0]
                category_url = typeimage[1]

                #--------- testing parsing out type from substring
                type_string = type_url.match(/(?<=type\/)(.*)(?=(.gif))/).to_s
                if category_url
                  category_string = category_url.match(/(?<=type\/)(.*)(?=(.png))/).to_s
                end

                pp type_string
                pp category_string
              end

              if info.length > 1 && needs_description == false
                # puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
                needs_description = true
                next
              end
              pokemon_product = MovesetProduct.new(pokemon_product_index, level_acquire, name, type_string, category_string, power_points, power, accuracy, effect_percent, description)
              pokemon_products.push(pokemon_product)
              # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
              needs_description = false
            else
              pokemon_product_index += -1
            end
          end

        end
      end
    end
  end

  csv_headers = ["index", "level/acquire","name", "type", "category", "pp", "power", "accuracy", "effect_percent", "description"]
  CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
    pokemon_products.each do |pokemon_product|
      csv << pokemon_product
      puts "Added to csv"
    end
  end

  attribute_titles = ["pokemon_name","move_name", "level_acquire", "pokemon_id", "move_id"]
  moveset_array = []
  count = 0
  pokemon_products.each do |moveset|
    single_moveset = {}
    count = 0
    if moveset.index.to_i > 0 #just for getting a clean list, we can do this in validations later
      single_moveset[attribute_titles[count].to_sym] = moveset[count + 1]
      single_moveset[:pokemon_name] = pokemon_model.name
      single_moveset[:move_name] = moveset[2]
      single_moveset[:level_acquire] = moveset[1]
      single_moveset[:pokemon_id] = Pokemon.find_by(name: pokemon_model.name).id
      single_moveset[:move_id] = Move.find_by(name: moveset[2]).id
      moveset_array << single_moveset
    end
  end
  # pp moveset_array[0]
  count = 1
  moveset_array.each do |moveset|
    puts "creating moveset model ##{count}"
    Moveset.create(moveset)
    count += 1
  end
end

csv_headers = ["index", "level/acquire","name", "type", "category", "pp", "power", "accuracy", "effect_percent", "description"]
CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
  pokemon_products.each do |pokemon_product|
    csv << pokemon_product
    puts "Added to csv"
  end
end