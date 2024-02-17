# frozen_string_literal: true

# == Schema Information
#
# Table name: chats
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  partner_id :string
#
class Chat < ApplicationRecord
  has_many :histories, dependent: :destroy, class_name: 'Chat::History', foreign_key: :chat_id

  def ignore_context?
    histories.blank? || histories.last.expired?
  end

  def last_context
    histories.last&.content
  end
end
