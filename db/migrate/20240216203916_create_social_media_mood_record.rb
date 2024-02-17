class CreateSocialMediaMoodRecord < ActiveRecord::Migration[7.1]
  class Settings < ActiveRecord::Base
    self.table_name = "place_holder_settings"
  end

  def up
    Settings.create(name: "social_media_mood", value: :negativo)
  end
end
