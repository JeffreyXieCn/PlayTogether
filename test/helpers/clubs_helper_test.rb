require 'test_helper'

class ClubsHelperTest < ActionView::TestCase

  def setup
    @user = users(:michael)
    @badminton = clubs(:badminton)
    @member = users(:lana)
    @nonmember = users(:malory)
  end

  test "get_club_admin returns the admin of the club" do
    assert_equal @user, get_club_admin(@badminton)
  end

  test "user_club_admin? returns true if a user is the admin of a club" do
    assert user_club_admin? @user, @badminton
  end

  test "user_club_admin? returns false if a user is not the admin of a club" do
    assert_not user_club_admin? @member, @badminton
  end

  test "user_in_club? returns true if a user is a member of a club" do
    assert user_in_club? @member, @badminton
  end

  test "user_in_club? returns false if a user is not a member of a club" do
    assert_not user_in_club? @nonmember, @badminton
  end
end