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
#  index_activities_on_club_id  (club_id)
#

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
