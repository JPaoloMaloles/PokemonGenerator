require "httparty"
require "nokogiri"
response = HTTParty.get("https://www.serebii.net/pokemon/nationalpokedex.shtml")
document = Nokogiri::HTML(response.body)

PokemonProduct = Struct.new(:info, :linetest, :url, :icon, :first_type_image, :second_type_image)

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
    end
    # puts "this is typeimage: #{typeimage.inspect}"
    # if !img_check.empty?
    #   url = "https://www.serebii.net" + html_product.css("a").first.attribute("href").value
    #   image = "https://www.serebii.net" + html_product.css("img").attribute("src").value
    #   image = "https://www.serebii.net" + html_product.css("img").attribute("src").value
    # end

    linetest = "#{count}"
    pokemon_product = PokemonProduct.new(info, linetest, url, icon, first_type_image, second_type_image)
    pokemon_products.push(pokemon_product)
  end

  csv_headers = ["info", "linetest", "url", "icon", "first_type_image", "second_type_image"]
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
