# config/initializers/bot_initializer.rb

if Rails.env.development?
  system("ruby bot.rb &")
end
