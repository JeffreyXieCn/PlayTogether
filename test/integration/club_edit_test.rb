require 'test_helper'

class ClubEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @badminton = clubs(:badminton)
    @basketball = clubs(:basketball)
  end

  test "a club admin can edit club info" do
    log_in_as(@user)
    get root_path
    assert_select 'a[href=?]', my_clubs_path, count: 1
    get my_clubs_path
    assert_template 'clubs/my'

    get club_path(@basketball) # user is not the admin of this club
    assert_template 'clubs/show'
    assert_select 'a[href=?]', edit_club_path(@basketball), text: 'Edit', count: 0

    get club_path(@badminton)
    assert_select 'a[href=?]', edit_club_path(@badminton), text: 'Edit'

    get edit_club_path(@badminton)

    new_name = @badminton.name + ' new name'
    new_description = @badminton.description + ' new description'
    patch club_path(@badminton), params: {club: {name: new_name,
                                                 description: new_description}}
    assert_not flash.empty?
    assert_redirected_to @badminton
    @badminton.reload
    assert_equal new_name,  @badminton.name
    assert_equal new_description, @badminton.description
  end
end
