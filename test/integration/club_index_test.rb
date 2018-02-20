require 'test_helper'

class ClubIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @badminton = clubs(:badminton)
    @football = clubs(:football)
  end
  test 'Login is not needed to view all the clubs' do
    get clubs_path
    assert_template 'clubs/index'
    assert_select 'ul.clubs' do
      assert_select 'li', 3
      assert_select 'a', text: 'edit', count:0
    end
  end

  test 'Logged in user can edit the club info if he is the club admin' do
    log_in_as(@user)
    get clubs_path
    assert_template 'clubs/index'
    assert_select 'ul.clubs' do
      assert_select 'li', 3
      assert_select 'a', text: 'edit', count:2
    end

    assert_select 'a[href=?]', edit_club_path(@badminton), text: 'edit'
    assert_select 'a[href=?]', edit_club_path(@football), text: 'edit'
  end
end
