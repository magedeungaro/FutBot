# frozen_string_literal: true

module OpenAi
  class Chat    
    def initialize
      @messages = []
      @retries = 0
    end

    def client
      @client ||= OpenAI::Client.new do |f|
        f.response :logger, Logger.new($stdout), bodies: true
      end
    end
    
    def chat(message)
      query = message.text
      set_previous_context(message.chat.id)
      @messages << { role: :user, content: query }
      analyze
      retry_analyze unless valid?
      persist_context(message.chat.id)
      @messages.last
    end

    private

    def retry_analyze
      @retries += 1
      analyze
    end

    def context_handler(chat_partner_id: nil)
      @context_handler ||= ContextHandler.new(chat_partner_id)
    end

    def set_previous_context(chat_partner_id)
      previous_context = context_handler(chat_partner_id:).previous_context
      if previous_context.present?
        @messages = @messages + previous_context 
      else
        @messages << Setup::PERSONALITY
      end
    end

    def persist_context(chat_partner_id)
      filtered_messages = @messages.reject { |message| [:function].include? message[:role] }
      context_handler(chat_partner_id:).update(@messages)
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
    
    def valid?
      !@messages.last[:content].match?('arguments') &&  @retries < 3
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
          messages: @messages,
          temperature: Setup::TEMPERATURE,
          functions: ToolCalls.functions
        }
      )

      response.deep_symbolize_keys if response.is_a?(Hash)
    end
  end
end
