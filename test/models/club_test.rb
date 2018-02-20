# == Schema Information
#
# Table name: clubs
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ClubTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @club = clubs(:badminton)
  end

  test "should be valid" do
    assert @club.valid?
  end

  test "name should be present" do
    @club.name = "  "
    assert_not @club.valid?
  end

  test "name should not be too long" do
    @club.name = "a" * 51
    assert_not @club.valid?
  end
end
