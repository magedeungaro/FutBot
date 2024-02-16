require 'telegram/bot'

Telegram::Bot::Client.run(ENV['TELEGRAM_API_TOKEN']) do |bot|
  bot.listen do |message|
    p message
  end
end
