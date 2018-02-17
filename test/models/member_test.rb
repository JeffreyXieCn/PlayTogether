# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  balance    :decimal(10, 2)
#  admin      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  club_id    :integer
#
# Indexes
#
#  index_members_on_club_id  (club_id)
#  index_members_on_user_id  (user_id)
#

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
