require 'test_helper'

class ClubIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @badminton = clubs(:badminton)
    @football = clubs(:football)
    @basketball = clubs(:basketball)
    @clubs_num = Club.count
    @hockey = clubs(:hockey)
  end
  test 'Login is not needed to view all the clubs' do
    get clubs_path
    assert_template 'clubs/index'
    assert_select 'ul.clubs' do
      assert_select 'li', @clubs_num
      #assert_select 'a', text: 'edit', count:0
    end
  end

  test 'Logged in user can edit the club info if he is the club admin' do
    log_in_as(@user)
    get my_clubs_path
    assert_template 'clubs/my'
    assert_select 'ul.clubs' do
      assert_select 'li', 3
      #assert_select 'a', text: 'edit', count:2
      assert_select 'a[href=?]', club_path(@badminton), text: @badminton.name
      assert_select 'a[href=?]', club_path(@basketball), text: @basketball.name
      assert_select 'a[href=?]', club_path(@football), text: @football.name
    end

    get club_path(@badminton)
    assert_template 'clubs/show'
    assert_select 'a[href=?]', edit_club_path(@badminton), text: 'edit'

    get club_path(@basketball)
    assert_template 'clubs/show'
    assert_select 'a[href=?]', edit_club_path(@basketball), text: 'edit', count: 0

    #assert_select 'a[href=?]', edit_club_path(@badminton), text: 'edit'
    #assert_select 'a[href=?]', edit_club_path(@football), text: 'edit'
  end

  test 'Logged in user should be able to join a club if he is not in already' do
    log_in_as(@user)
    get clubs_path
    assert_template 'clubs/index'
    assert_select 'ul.clubs' do
      assert_select 'a', text: @hockey.name, count: 1
    end

    get club_path(@hockey)
    assert_template 'clubs/show'
    assert_select 'a', text: 'join', count: 1

    assert_difference 'Member.where(club_id: @hockey.id).count', 1 do
      post join_club_path(@hockey)
    end

    assert_redirected_to @hockey
    follow_redirect!
    assert_not flash.empty?
    assert_not_empty 'div.alert.alert-success'

    # check that there is no more link to join
    assert_select 'a', text: 'join', count: 0

    # check that hockey shows on my clubs page
    get my_clubs_path
    assert_template 'clubs/my'
    assert_select 'ul.clubs' do
      assert_select 'li', html: /#{Regexp.quote(@hockey.name)}/
    end

  end
end
