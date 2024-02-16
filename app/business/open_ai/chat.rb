# frozen_string_literal: true

module OpenAi
  class Chat
    GPT_MODEL = 'gpt-4-1106-preview'
    TEMPERATURE = 0.7

    attr_accessor :messages # apenas para teste
    def initialize
      @messages = [] << Prompts::PERSONALITY
    end

    def client
      @client ||= OpenAI::Client.new do |f|
        f.response :logger, Logger.new($stdout), bodies: true
      end
    end

    def chat(query)
      @messages << { role: :user, content: query }
      run
    end

    def run(context: nil)
      if context.present?
        @messages << Prompts::CONTEXTS[context]
        @messages << Prompts::GOALS[context]
      end
      response = chat_completion
      message = response.dig(:choices, 0, :message)
      content = message[:content]
      @messages << { role: :assistant, content: }
      @messages.last
    end

    def add_system_context(content)
      @messages << {
        role: :system,
        content:
      }
    end

    private

    def chat_completion
      response = client.chat(
        parameters: {
          model: GPT_MODEL,
          messages: @messages,
          temperature: TEMPERATURE
        }
      )

      response.deep_symbolize_keys if response.is_a?(Hash)
    end
  end
end
