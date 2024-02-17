# config/initializers/bot_initializer.rb
Rails.application.config.after_initialize do
  Thread.new do
    @telegram_bot = Integration::Bot.instance
    @telegram_bot.run
  end
end