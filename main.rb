require "json"
require "net/http"

require_relative "lib/clothes_item"
require_relative "lib/wardrobe"
require_relative "lib/open_weather_map"
require_relative ""

# конфигурация
city = "Moscow"
api_key = "e809fbd81e2a508842b45ad0a5c8bbc9"
sereadsheet_key = "1bPT458nCSWahOXu6FcRmv3ASWC1Yl0UuyiTlTRCBUAI"

#------------


Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    else
    temperature = open_weather_current_temperature

    temperature_text = "По данным openweathermap.org в Москве сейчас #{temperature}°C"

    wardrobe = Wardrobe.new(sereadsheet_key)

    items = wardrobe.random_suitable_items(temperature)

      items_text = "Предлагая сегодня надеть:\n\n"
      # a = "foo"
      # a += "bar"
      # => "foobar"
      # a = a + "bar"
      items_text += items.map { |item| "#{item.info}\n" }

    bot.api.send_message(chat_id: message.chat.id, text: temperature_text)
    bot.api.send_message(chat_id: message.chat.id, text: items_text)

    end
  end
end
end
