# == Schema Information
#
# Table name: players
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  activity_id :integer
#  cost        :decimal(10, 2)   default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_players_on_activity_id  (activity_id)
#  index_players_on_user_id      (user_id)
#

class Player < ApplicationRecord
  belongs_to :user
  belongs_to :activity
end
