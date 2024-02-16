# frozen_string_literal: true

module OpenAi
  class Chat
    GPT_MODEL = 'gpt-4-1106-preview'
    TEMPERATURE = 0.7

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
      analyze
      @messages.last
    end

    private

    def analyze
      response = chat_completion
      message = response.dig(:choices, 0, :message)
      content = message[:content]
      @messages << { role: :assistant, content: } if content.present?

      return unless function_call?(message)

      @messages << { role: :assistant, content: message[:function_call].to_json }
      results = execute_function_call(message)

      @messages << results

      analyze
    end

    def execute_function_call(message)
      function = message.dig(:function_call, :name).to_sym
      return "#{function} is not a valid function." unless ToolCalls.respond_to?(function)

      ToolCalls.method(function).call
    end

    def function_call?(message)
      message.try(:[], :role) == 'assistant' && message.try(:[], :function_call)
    end

    def chat_completion
      response = client.chat(
        parameters: {
          model: GPT_MODEL,
          messages: @messages,
          temperature: TEMPERATURE,
          functions: ToolCalls.functions
        }
      )

      response.deep_symbolize_keys if response.is_a?(Hash)
    end
  end
end
