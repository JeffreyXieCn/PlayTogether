require 'test_helper'

# A visitor can sign up as a user
# A user can see clubs' info, members and activities
# A user can join a club as a member (TODO: joining a club is subject to the approval of the club admin)
# A memebr can join an activity as a player
# A member can pay his membership fee to cover the cost of activities
# A user can see the clubs he joined on his profile page

class ClubsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @badminton = clubs(:badminton)
    @basketball = clubs(:basketball)
    @other_user = users(:archer)
  end

  test "should redirect new when not logged in" do
    get new_club_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect my clubs when not logged in" do
    get my_clubs_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_club_path(@badminton)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch club_path(@badminton), params: { club: { name: @badminton.name,
                                              description: @badminton.description } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not the admin of the club" do
    log_in_as(@other_user)
    get edit_club_path(@badminton)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not the admin of the club" do
    log_in_as(@other_user)
    patch club_path(@badminton), params: { club: { name: @badminton.name,
                                                   description: @badminton.description } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test 'admin should be able to update club info' do
    log_in_as(@user)
    new_name = @badminton.name + ' new name'
    patch club_path(@badminton), params: { club: { name: new_name,
                                                   description: @badminton.description } }
    assert_not flash.empty?
    @badminton.reload
    assert_equal new_name, @badminton.name
  end

  test 'a club member should be able to see all the members of the club' do
    log_in_as(@user)
    get members_club_path(@basketball)
    members = assigns(:club_members)
    assert_equal 3, members.count
  end

  test "should redirect view members of a club when not logged in" do
    get members_club_path(@basketball)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "a user can see the members of any club" do
    log_in_as(@other_user)
    get members_club_path(@badminton)
    assert flash.empty?
    members = assigns(:club_members)
    assert_equal 2, members.count
  end

end
