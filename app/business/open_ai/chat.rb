# frozen_string_literal: true

module OpenAi
  class Chat    
    def initialize
      @messages = [] << Setup::PERSONALITY
    end

    def client
      @client ||= OpenAI::Client.new do |f|
        f.response :logger, Logger.new($stdout), bodies: true
      end
    end
    
    def chat(message)
      binding.pry
      query = message.text
      set_previous_context(message.chat.id)
      @messages << { role: :user, content: query }
      analyze
      retry_analyze unless valid?
      @messages.last
    end

    private

    def set_previous_context(chat_partner_id)
      @messages << ContextHandler.new(chat_partner_id).previous_context
    end
    
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
    alias_method :retry_analyze, :analyze
    
    def valid?
      !@messages.last[:content].match?('arguments')
    end

    def execute_function_call(message)
      function = message.dig(:function_call, :name).to_sym
      return "#{function} is not a valid function." unless ToolCalls.respond_to?(function)
      
      args = JSON.parse(message.dig(:function_call, :arguments)).deep_symbolize_keys
      results = ToolCalls.method(function).call(**args)
      results.nil? ? "Function call #{function} failed." : results
    end

    def function_call?(message)
      message.try(:[], :role) == 'assistant' && message.try(:[], :function_call).present?
    end

    def chat_completion
      response = client.chat(
        parameters: {
          model: Setup::GPT_MODEL,
          messages: @messages.compact!,
          temperature: Setup::TEMPERATURE,
          functions: ToolCalls.functions
        }
      )

      response.deep_symbolize_keys if response.is_a?(Hash)
    end
  end
end
