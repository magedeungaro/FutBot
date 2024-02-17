# frozen_string_literal: true

module Integration
  class Bot
    include Singleton

    def initialize;end

    def run
      ::Telegram::Bot::Client.run(ENV['TELEGRAM_API_TOKEN']) do |bot|
        bot.listen do |message|
          service = Telegram::ResponseService.new
          response = service.create_reponse(message)
          bot.api.send_message(chat_id: message.chat.id, text: response)
        end
      end
    end
  end
end
