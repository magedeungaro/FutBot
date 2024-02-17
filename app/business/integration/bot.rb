# frozen_string_literal: true

module Integration
  class Bot
    def initialize;end

    def run
      ::Telegram::Bot::Client.run(ENV['TELEGRAM_API_TOKEN']) do |bot|
        bot.listen do |message|
          service = Telegram::ResponseService.new
          response = service.create_reponse(message)
          bot.api.send_message(chat_id: message.chat.id, text: response)
        rescue
          bot.api.send_message(chat_id: message.chat.id, text: 'Something went wrong. Please try again later.')
        end
      end
    end
  end
end
