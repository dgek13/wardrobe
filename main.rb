require "json"
require "net/http"

require_relative "lib/clothes_item"
require_relative "lib/wardrobe"
require_relative "lib/open_weather_map"

# конфигурация
city = "Moscow"
api_key = "e809fbd81e2a508842b45ad0a5c8bbc9"
sereadsheet_key = "1bPT458nCSWahOXu6FcRmv3ASWC1Yl0UuyiTlTRCBUAI"

#------------

temperature = open_weather_current_temperature

puts "По данным openweathermap.org в Москве сейчас #{temperature}°C"

wardrobe = Wardrobe.new(sereadsheet_key)

items = wardrobe.random_suitable_items(temperature)


items.each do |item|
  puts item.info
end
