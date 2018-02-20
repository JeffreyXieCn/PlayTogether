# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  balance    :decimal(10, 2)   default(0.0)
#  admin      :boolean          default(FALSE)
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
  def setup
    @badminton_admin = members(:badminton_admin)
    @badminton_member = members(:badminton_member_lana)
  end

  test "by default a club member is not admin" do
    assert_not @badminton_member.admin?
  end
end
