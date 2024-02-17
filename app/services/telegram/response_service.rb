# fronzen_string_literal: true

module Telegram
  class ResponseService

    def initialize
      @gpt_instance = OpenAi::Chat.new
    end

    def create_reponse(message)
      @gpt_instance.chat(message.text)[:content]
    end
  end
end
