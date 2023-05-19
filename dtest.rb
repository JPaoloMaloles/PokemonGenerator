require "httparty"
require "nokogiri"
# downloading the target web page
response = HTTParty.get("https://www.serebii.net/pokemon/nationalpokedex.shtml")
# parsing the HTML document returned by the server
document = Nokogiri::HTML(response.body)

# defining a data structure to store the scraped data
PokemonProduct = Struct.new(:url, :linetest, :image)

# # selecting all HTML product elements
html_products = document.css("table.dextable")
html_products = html_products.css("tr")
# html_products = document.css("td.fooinfo")
html_products = document.css("table.pkmn")

# initializing the list of objects
# that will contain the scraped data
pokemon_products = []
html_product.css("td")