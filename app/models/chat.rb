# frozen_string_literal: true

# == Schema Information
#
# Table name: chats
#
#  id         :integer          not null, primary key
#  history    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  partner_id :string
#
class Chat < ApplicationRecord
end
