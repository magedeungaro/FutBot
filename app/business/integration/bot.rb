# frozen_string_literal: true

module Integration
  class Bot
    def initialize;end

    def run
      ::Telegram::Bot::Client.run(ENV['TELEGRAM_API_TOKEN']) do |bot|
        bot.listen do |message|
          service = Telegram::ResponseService.new
          case message.text
          when '/start'
            path_to_photo = File.expand_path('app/assets/images/mascote.jpeg')
            bot.api.send_photo(chat_id: message.chat.id, photo: Faraday::UploadIO.new(path_to_photo, 'image/jpeg'), caption: "Fala #{message.from.first_name}! Eu sou o Biriba, seu novo assistente para os assuntos do Fogão. Como posso te ajudar?")
          else
            response = service.create_reponse(message)
            bot.api.send_message(chat_id: message.chat.id, text: response)
          end
        rescue
          bot.api.send_message(chat_id: message.chat.id, text: 'Opa, deu ruim aqui, brother. Tenta de novo aí.')
        end
      end
    end
  end
end
