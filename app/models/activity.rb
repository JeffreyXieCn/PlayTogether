# == Schema Information
#
# Table name: activities
#
#  id          :integer          not null, primary key
#  club_id     :integer
#  name        :string
#  description :text
#  start_time  :datetime
#  end_time    :datetime
#  where       :string
#  total_cost  :decimal(10, 2)
#  status      :integer          default("scheduled")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_activities_on_club_id                 (club_id)
#  index_activities_on_club_id_and_start_time  (club_id,start_time)
#

class Activity < ApplicationRecord
  belongs_to :club
  has_many :players
  enum status: [:scheduled, :proposed, :completed, :cancelled]

  default_scope -> { order(start_time: :asc) } # show the next upcoming activity on the top
end
