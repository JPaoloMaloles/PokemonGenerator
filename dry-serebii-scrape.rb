require "httparty"
require "nokogiri"
multiword_ability = ["Air Lock", "Anger Point", "Anger Shell", "Arena Trap", "Armor Tail", "Aroma Veil", "As One", "Aura Break", "Bad Dreams", "Ball Fetch", "Battle Armor", "Battle Bond", "Beads of Ruin", "Beast Boost", "Big Pecks", "Cheek Pouch", "Chilling Neigh", "Clear Body", "Color Change", "Compoundeyes", "Cotton Down", "Cud Chew", "Curious Medicine", "Cursed Body", "Cute Charm", "Dark Aura", "Dauntless Shield", "Delta Stream", "Desolate Land", "Dragon's Maw", "Dry Skin", "Early Bird", "Earth Eater", "Effect Spore", "Electric Surge", "Emergency Exit", "Fairy Aura", "Flame Body", "Flame Boost", "Flash Fire", "Flower Gift", "Flower Veil", "Friend Guard", "Full Metal Body", "Fur Coat", "Gale Wings", "Good as Gold", "Gorilla Tactics", "Grass Pelt", "Grassy Surge", "Grim Neigh", "Guard Dog", "Gulp Missile", "Hadron Engine", "Heavy Metal", "Honey Gather", "Huge Power", "Hunger Switch", "Hyper Cutter", "Ice Body", "Ice Face", "Ice Scales", "Innards Out", "Inner Focus", "Intrepid Sword", "Iron Barbs", "Iron Fist", "Keen Eye", "Leaf Guard", "Light Metal", "Lightning Rod", "Lingering Aroma", "Liquid Ooze", "Liquid Voice", "Long Reach", "Magic Bounce", "Magic Guard", "Magma Armor", "Magnet Pull", "Marvel Scale", "Mega Launcher", "Mirror Armor", "Misty Surge", "Mold Breaker", "Motor Drive", "Mycelium Might", "Neutralizing Gas", "No Guard", "Orichalcum Pulse", "Own Tempo", "Parental Bond", "Pastel Veil", "Perish Body", "Poison Heal", "Poison Touch", "Power Construct", "Power of Alchemy", "Power Spot", "Primordial Sea", "Prism Armor", "Propellor Tail", "Psychic Surge", "Punk Rock", "Pure Power", "Purifying Salt", "Quark Drive", "Queenly Majesty", "Quick Draw", "Quick Feet", "Rain Dish", "RKS System", "Rock Head", "Rocky Payload", "Rough Skin", "Run Away", "Sand Force", "Sand Rush", "Sand Spit", "Sand Stream", "Sand Veil", "Sap Sipper", "Screen Cleaner", "Seed Sower", "Serene Grace", "Shadow Shield", "Shadow Tag", "Shed Skin", "Shell Armor", "Shield Dust", "Shields Down", "Skill Link", "Slow Start", "Slush Rush", "Snow Cloack", "Snow Warning", "Solar Power", "Solid Rock", "Speed Boost", "Stance Change", "Steam Engine", "Steely Spirit", "Sticky Hold", "Storm Drain", "Strong Jaw", "Suction Cups", "Super Luck", "Surge Surfer", "Sweet Veil", "Sword of Ruin", "Tablets of Ruin", "Tangled Feet", "Tangling Hair", "Thick Fat", "Tinted Lens", "Tough Claws", "Toxic Boost", "Toxic Debris", "Unseen Fist", "Vessel of Ruin", "Victory Star", "Vital Spirit", "Volt Absorb", "Wandering Spirit", "Water Absorb", "Water Bubble", "Water Veil", "Weak Armor", "Well-Baked Body", "White Smoke", "Wimp Out", "Wind Power", "Wind Rider", "Wonder Guard", "Zen Mode", "Zero to Hero"]
response = HTTParty.get("https://www.serebii.net/pokemon/nationalpokedex.shtml")
document = Nokogiri::HTML(response.body)

PokemonProduct = Struct.new(:info, :linetest, :url, :icon, :first_type_image, :second_type_image, :first_type, :second_type)

html_products = document.css("table.dextable")
html_products = html_products.css("tr")

pokemon_products = []

count = -2
html_products.each do |html_product|
  info = "#{html_product.css("td").text} "
  inforaw = html_product.css("td")
  img_check = inforaw.css("img")
  if !(info.inspect == "\" \"")
    puts "THIS IS ITERATION--------------------------------------------------------: #{count}"
    info = []
    typeimage = []
    url = nil

    count += 1

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
          puts item
          multiword_ability.each do |ability|
            if item.include?(ability)
              puts "THERES A SPACE"
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
      first_type_string = first_type_image.match(/(?<=(type))(.*)(?=(.gif))/).to_s
      first_type_string = first_type_string.gsub("/", "")
      first_type = first_type_string

      if second_type_image
        second_type_string = second_type_image.match(/(?<=(type))(.*)(?=(.gif))/).to_s
        second_type_string = second_type_string.gsub("/", "")
        second_type = second_type_string
      end
    end
    # puts "this is typeimage: #{typeimage.inspect}"
    # if !img_check.empty?
    #   url = "https://www.serebii.net" + html_product.css("a").first.attribute("href").value
    #   image = "https://www.serebii.net" + html_product.css("img").attribute("src").value
    #   image = "https://www.serebii.net" + html_product.css("img").attribute("src").value
    # end

    linetest = "#{count}"
    pokemon_product = PokemonProduct.new(info, linetest, url, icon, first_type_image, second_type_image, first_type, second_type)
    pokemon_products.push(pokemon_product)
  end

  csv_headers = ["info", "linetest", "url", "icon", "first_type_image", "second_type_image", "first_type", "second_type"]
  CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
    pokemon_products.each do |pokemon_product|
      csv << pokemon_product
    end
  end
end

pokemon_products.each do |pokemon_product|
  pokemon_product.each do |attribute|
    puts attribute
  end
end
