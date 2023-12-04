require "httparty"
require "nokogiri"
url_paths = ["physical","special", "other"]

pokemon_product_index = -1
pokemon_products = []

MoveProduct = Struct.new(:index, :name, :type, :category, :pp, :power, :accuracy,)

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
        pokemon_product = MoveProduct.new(pokemon_product_index, name, type, category, power_points, power, accuracy)
        pokemon_products.push(pokemon_product)
      else
        pokemon_product_index += -1
      end

    end
  end
end


csv_headers = ["index", "name", "type", "category", "pp", "power", "accuracy"]
CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
  pokemon_products.each do |pokemon_product|
    csv << pokemon_product
  end
end

attribute_titles = ["name", "type", "category", "pp", "power", "accuracy"]
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