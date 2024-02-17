# frozen_string_literal: true

require 'telegram/bot'

module Integration
  class Bot
    def initialize
      @gpt_service = ::Telegram::ResponseService.new
    end

    def run
      ::Telegram::Bot::Client.run(ENV['TELEGRAM_API_TOKEN']) do |bot|
        bot.listen do |message|
          response = @gpt_service.create_reponse(message)
          bot.api.send_message(chat_id: message.chat.id, text: response)
        end
      end
    end
  end
end
