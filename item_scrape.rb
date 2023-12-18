require "httparty"
require "nokogiri"
url_paths = ["pokeball","holditem","evolutionary","berry","vitamins","fossil","miscellaneous",]

pokemon_product_index = -1
pokemon_products = []

ItemProduct = Struct.new(:index, :image, :name, :effect)

url_paths.each do |url_path|
  response = HTTParty.get("https://www.serebii.net/itemdex/list/#{url_path}.shtml")

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
        # puts "This is tempinfo: #{tempinfo}"
        tempinfo.each do |item|
          if item.match?(/[0-9A-Za-z]/)
            # puts "IT WORKS"
            info << item
          end
        end
        # puts "AGAIN WE DO THIS: #{info}"
      end
    
      name = info[0]

      if info[1]
        # puts "info1 is #{info[1]}"
        description = info[1].gsub!("Pok", "Poke") || info[1]
        # puts description
      end


      # puts images_url
      item_image = ""
      if !img_check.empty?
        item_image = "https://www.serebii.net" + inforaw.css("img").attribute("src").value
      end

      # p item_image
      # p name
      # p description

      if name != "Picture"
        pokemon_product = ItemProduct.new(pokemon_product_index, item_image, name, description)
        pokemon_products.push(pokemon_product)
      else
        pokemon_product_index += -1
      end

    end
  end
end


csv_headers = ["index", "image", "name", "effect"]
CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
  pokemon_products.each do |pokemon_product|
    csv << pokemon_product
  end
end

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

# pokemon_product = ItemProduct.new("a", "b", "c")
# # pokemon_products.push(pokemon_product)


# csv_headers = ["image", "name", "effect"]
# CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
#   pokemon_products.each do |pokemon_product|
#     csv << pokemon_product
#   end
# end