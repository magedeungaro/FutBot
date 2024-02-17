class CreateChatHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_histories do |t|
      t.references :chat, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
