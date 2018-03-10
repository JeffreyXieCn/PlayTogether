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

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  def setup
    @first_badminton = activities(:first_badminton)
    @badminton = @first_badminton.club
  end

  test 'By default a new activity should have status scheduled' do
    assert_equal 'scheduled', @first_badminton.status
  end

  test 'order should be the next upcoming activity on the top' do
    assert_equal @first_badminton, @badminton.activities.first
  end
end
