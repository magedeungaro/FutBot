# == Schema Information
#
# Table name: chat_histories
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :integer          not null
#
# Indexes
#
#  index_chat_histories_on_chat_id  (chat_id)
#
# Foreign Keys
#
#  chat_id  (chat_id => chats.id)
#
class Chat::History < ApplicationRecord
  belongs_to :chat

  def expired?
    updated_at < 2.min.ago
  end
end
