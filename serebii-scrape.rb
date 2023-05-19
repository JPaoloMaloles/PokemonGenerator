require "httparty"
require "nokogiri"
# downloading the target web page
response = HTTParty.get("https://www.serebii.net/pokemon/nationalpokedex.shtml")
# parsing the HTML document returned by the server
document = Nokogiri::HTML(response.body)

# defining a data structure to store the scraped data
PokemonProduct = Struct.new(:info, :linetest, :image, :url, :typeimage)

# # selecting all HTML product elements
html_products = document.css("table.dextable")
html_products = html_products.css("tr")
#html_products = document.css("td.fooinfo")
# html_products = document.css("table.pkmn")

# initializing the list of objects
# that will contain the scraped data
pokemon_products = []

# puts document
#puts html_products

# iterating over the list of HTML products
count = -2
html_products.each do |html_product|
  info = "#{html_product.css("td").text} "
  inforaw = html_product.css("td")
  img_check = inforaw.css("img")
  if !(info.inspect == "\" \"")
    puts "THIS IS ITERATION--------------------------------------------------------: #{count}"
    typeimage = []
    info = []
    url = nil
    image = nil
    count += 1

    #this code sets the :info attribute of PokemonProduct
    inforaw.each do |item|
      tempinfo = []
      clean_inspect = item.text.inspect.gsub("\\r\\n\\t", "")
      clean_inspect = clean_inspect.gsub("\\t", "")
      clean_inspect = clean_inspect.gsub!(/[^0-9A-Za-z\s]/, "")
      #clean_inspect = clean_inspect.remove('\\"')
      #clean_inspect = item.text.inspect.class
      # puts "this is Item: #{item.text}"
      # puts "this is Item.Inspect: #{item.text.inspect}"
      puts "this is Clean_Inspect: #{clean_inspect}"
      tempinfo << clean_inspect
      puts "This is tempinfo: #{tempinfo}"
      tempinfo.each do |item|
        #if item != '""' && item != "" && item != '" "' && item.match?(/[0-9A-Za-z]/)
        if item.match?(/[0-9A-Za-z]/)
          info << item
        end
      end
      puts "AGAIN WE DO THIS: #{info}"
    end

    # tempinfo = html_product.css("tr")
    # info = tempinfo.css("td").text

    # puts "this is inforaw: #{inforaw}"
    images_url = inforaw.css("img")
    puts images_url
    if !img_check.empty?
      images_url.each do |image_url|
        puts "This is image_url: #{image_url}"
        puts "this is image_url.css: #{image_url.attribute("src").value}"
        typeimage << "https://www.serebii.net" + image_url.attribute("src").value
      end
    end
    puts "this is typeimage: #{typeimage.inspect}"
    if info.inspect == "\" \""
      puts "info node is empty"
    end
    if !img_check.empty?
      url = "https://www.serebii.net" + html_product.css("a").first.attribute("href").value
      image = "https://www.serebii.net" + html_product.css("img").attribute("src").value
      image = "https://www.serebii.net" + html_product.css("img").attribute("src").value
    end
    # puts "this is info: #{info.empty?}"
    # puts "@#{info.inspect}@"
    # puts "this is image: #{image}"
    # puts "this is url: #{url}"

    linetest = "#{count}"

    puts "IT GOT CREATED"
    # storing the scraped data in a PokemonProduct object
    pokemon_product = PokemonProduct.new(info, linetest, image, url, typeimage)
    # adding the PokemonProduct to the list of scraped objects
    pokemon_products.push(pokemon_product)
  end

  # defining the header row of the CSV file
  csv_headers = ["info", "linetest", "image", "url", "typeimage"]
  CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
    # adding each pokemon_product as a new row
    # to the output CSV file
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
