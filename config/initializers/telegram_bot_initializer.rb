# config/initializers/bot_initializer.rb
Rails.application.config.after_initialize do
  Thread.new do
    @telegram_bot = Integration::Bot.instance
    begin
      @telegram_bot.run
    rescue StandardError => e
      Rails.logger.error "Telegram bot error: #{e.message}"
    end
  end
end