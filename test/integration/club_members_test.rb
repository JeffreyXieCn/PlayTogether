require 'test_helper'

class ClubMembersTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @badminton = clubs(:badminton)
    @basketball = clubs(:basketball)
    @clubs_num = Club.count
    @hockey = clubs(:hockey)
  end

  test "Non-logged in visitor can't view the members of a club" do
    get clubs_path
    assert_select 'ul.clubs' do
      assert_select 'a', text: 'view members', count: 0
    end
  end

  test "A logged in member of a club can view all the members of that club" do
    log_in_as(@user)
    get clubs_path
    assert_select 'ul.clubs' do
      assert_select 'a', text: 'view members', count: 3
    end

    get members_club_path(@basketball)
    assert_template 'clubs/members'

    members_count = @basketball.members.count
    assert_select 'table.club_members' do
      assert_select 'tr', count: members_count + 1 # there is a header row for this table
    end

  end
end
