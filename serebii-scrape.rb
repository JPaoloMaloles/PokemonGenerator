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
# puts html_products

# iterating over the list of HTML products
count = 0
html_products.each do |html_product|
  puts "THIS IS ITERATION--------------------------------------------------------: #{count}"
  typeimage = "default"
  url = nil
  image = nil
  count += 1
  # tempinfo = html_product.css("tr")
  # info = tempinfo.css("td").text

  info = "#{html_product.css("td").text} "
  inforaw = html_product.css("td")
  html_inforaw = inforaw.css("img")
  # puts "this is inforaw: #{inforaw}"
  # puts "this is HTML inforaw: @#{html_inforaw}@"
  if info.inspect == "\" \""
    puts "info node is empty"
  end
  puts "this is info: #{info.empty?}"
  puts "@#{info.inspect}@"
  if !html_inforaw.empty?
    url = "https://www.serebii.net" + html_product.css("a").first.attribute("href").value
    image = "https://www.serebii.net" + html_product.css("img").first.attribute("src").value
  end
  puts "this is image: #{image}"
  puts "this is url: #{url}"
  linetest = "#{count}"
  # url = "https://www.serebii.net" + html_product.css("a").first.attribute("href").value
  # image = "https://www.serebii.net" + html_product.css("img").first.attribute("src").value
  # name = html_product.css("h2").first.text
  # price = html_product.css("span").first.text
  if !(info.inspect == "\" \"")
    puts "IT GOT CREATED"
    # storing the scraped data in a PokemonProduct object
    pokemon_product = PokemonProduct.new(info, linetest, image, url, typeimage)
    # adding the PokemonProduct to the list of scraped objects
    pokemon_products.push(pokemon_product)
  end
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
