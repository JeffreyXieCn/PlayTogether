require 'test_helper'

class ClubMembersTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @badminton = clubs(:badminton)
    @basketball = clubs(:basketball)
    @clubs_num = Club.count
    @hockey = clubs(:hockey)
    @other_user = users(:archer)
  end

  test 'a logged in user can view the members of a club' do
    log_in_as(@other_user)
    get clubs_path
    assert_template 'clubs/index'

    assert_select 'ul.clubs' do
      assert_select 'a', text: @badminton.name, count: 1
    end

    get club_path(@badminton)
    assert_template 'clubs/show'
    assert_select 'a', text: 'View members', count: 1
    get members_club_path(@badminton)
    assert_template 'clubs/members'
  end

  test 'a logged in member of a club can view all the members of that club' do
    log_in_as(@user)
    get club_path(@basketball)
    assert_select 'a', text: 'View members', count: 1

    get members_club_path(@basketball)
    assert_template 'clubs/members'

    members_count = @basketball.members.count
    assert_select 'table.club_members' do
      assert_select 'tr', count: members_count + 1 # there is a header row for this table
    end

  end

  test 'Logged in user should be able to join a club if he is not already a member' do
    log_in_as(@user)
    get clubs_path
    assert_template 'clubs/index'
    assert_select 'ul.clubs' do
      assert_select 'a', text: @hockey.name, count: 1
    end

    get club_path(@hockey)
    assert_template 'clubs/show'
    assert_select 'a', text: 'Join', count: 1

    assert_difference 'Member.where(club_id: @hockey.id).count', 1 do
      post join_club_path(@hockey)
    end

    assert_redirected_to @hockey
    follow_redirect!
    assert_not flash.empty?
    assert_not_empty 'div.alert.alert-success'

    # check that there is no more link to join
    assert_select 'a', text: 'Join', count: 0

    # check that hockey shows on my clubs page
    get my_clubs_path
    assert_template 'clubs/my'
    assert_select 'ul.clubs' do
      assert_select 'li', html: /#{Regexp.quote(@hockey.name)}/
    end

    # check that the Join link disappears
    get club_path(@hockey)
    assert_select 'a', text: 'Join', count: 0

  end
end
