require 'test_helper'

class ClubIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @badminton = clubs(:badminton)
    @football = clubs(:football)
    @clubs_num = Club.count
    @hockey = clubs(:hockey)
  end
  test 'Login is not needed to view all the clubs' do
    get clubs_path
    assert_template 'clubs/index'
    assert_select 'ul.clubs' do
      assert_select 'li', @clubs_num
      assert_select 'a', text: 'edit', count:0
    end
  end

  test 'Logged in user can edit the club info if he is the club admin' do
    log_in_as(@user)
    get clubs_path
    assert_template 'clubs/index'
    assert_select 'ul.clubs' do
      assert_select 'li', @clubs_num
      assert_select 'a', text: 'edit', count:2
    end

    assert_select 'a[href=?]', edit_club_path(@badminton), text: 'edit'
    assert_select 'a[href=?]', edit_club_path(@football), text: 'edit'
  end

  test 'Logged in user should be able to join a club if he is not in already' do
    log_in_as(@user)
    get clubs_path
    assert_template 'clubs/index'
    assert_select 'ul.clubs' do
      assert_select 'a', text: 'join', count: 1
    end

    assert_difference 'Member.where(club_id: @hockey.id).count', 1 do
      post join_club_path(@hockey)
    end

    assert_redirected_to @hockey
    follow_redirect!
    assert_not flash.empty?
    assert_not_empty 'div.alert.alert-success'

    # check that there is no more link to join
    get clubs_path
    assert_template 'clubs/index'
    assert_select 'ul.clubs' do
      assert_select 'a', text: 'join', count: 0
    end
  end
end
