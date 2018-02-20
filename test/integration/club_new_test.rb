require 'test_helper'

class ClubNewTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  #
  def setup
    @user = users(:michael)
  end

  test "create a new club" do
    log_in_as(@user)
    get root_path
    assert_select 'a[href=?]', new_club_path, count: 1

    get new_club_path
    assert_template 'clubs/new'
    name = "Coding club"
    description = "Keep coding, keep improving"
    assert_difference ['Club.count', 'Member.count'], 1 do
      post clubs_path, params: {club:{name: name,
                                      description: description}}
    end

    club = assigns(:club)
    club_admin = get_club_admin(club)
    assert_equal @user, club_admin

    follow_redirect!
    assert_template 'clubs/show'
    assert_not_empty 'div.alert.alert-success'

  end

end
