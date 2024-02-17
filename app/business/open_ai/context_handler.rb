module OpenAi
  class ContextHandler
    def initialize(chat_partner_id)
      @chat = ::Chat.find_or_create_by!(partner_id: chat_partner_id)
    end

    def previous_context
      return unless chat_context

      @previous_context ||= JSON.parse(chat_context)
    end

    def update(context)
      if @chat.ignore_context?
        ::Chat::History.create!(content: JSON.generate(context), chat: @chat)
      else
        @chat.histories.last.update(content: JSON.generate(context))
      end
    end

    private
    
    def chat_context
      @chat.last_context unless @chat.ignore_context?
    end
  end
end
