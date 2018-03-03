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
  test 'Login is needed to view all the clubs' do
    log_in_as(@user)
    get clubs_path
    assert_template 'clubs/index'
    assert_select 'ul.clubs' do
      assert_select 'li', @clubs_num
    end
  end

  test 'Logged in user can see the clubs he joined' do
    log_in_as(@user)
    get my_clubs_path
    assert_template 'clubs/my'
    assert_select 'ul.clubs' do
      assert_select 'li', 3
      assert_select 'a[href=?]', club_path(@badminton), text: @badminton.name
      assert_select 'a[href=?]', club_path(@basketball), text: @basketball.name
      assert_select 'a[href=?]', club_path(@football), text: @football.name
    end
  end
end
