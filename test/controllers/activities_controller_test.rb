require 'test_helper'

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @badminton = clubs(:badminton)
    @first_badminton = activities(:first_badminton)
    @other_user = users(:archer)
  end
  test 'should redirect index if not logged in' do
    get club_activities_path(@badminton)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "A logged in user can see a club's activities" do
    log_in_as(@other_user)
    get club_activities_path(@badminton)
    assert_response :success
  end

  test 'should redirect show if not logged in' do
    get activity_path(@first_badminton)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'A logged in user can show an activity' do
    log_in_as(@other_user)
    get activity_path(@first_badminton)
    assert_response :success
  end
end
