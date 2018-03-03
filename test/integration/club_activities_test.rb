require 'test_helper'

class ClubActivitiesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @badminton = clubs(:badminton)
    @basketball = clubs(:basketball)
    @clubs_num = Club.count
    @hockey = clubs(:hockey)
    @other_user = users(:archer)
  end

  test 'a logged in user can view the activities of a club' do
    log_in_as(@other_user)
    get clubs_path
    assert_template 'clubs/index'

    assert_select 'ul.clubs' do
      assert_select 'a', text: @badminton.name, count: 1
    end

    get club_path(@badminton)
    assert_template 'clubs/show'
    assert_select 'a', text: 'View activities', count: 1
    get club_activities_path(@badminton)
    assert_template 'activities/index'

    activity_count = @badminton.activities.count

    assert_select 'ul.activities' do
      assert_select 'li', count: activity_count
    end

  end

  test 'club admin can create a new activity' do
    log_in_as(@user)
    get club_activities_path(@badminton)
    assert_template 'activities/index'
    assert_select 'a', text: 'New activity', count: 1

    get new_club_activity_path(@badminton)
    assert_template 'activities/new'

    name = "Another badminton night"
    description = "Come out and play"
    start_time = '2018-03-17 19:00:00'
    end_time = '2018-03-17 20:00:00'
    where = 'Sports Complex, court #3'
    total_cost = '8'
    assert_difference '@badminton.activities.count', 1 do
      post club_activities_path(@badminton), params: {activity: {name: name,
                                                                 description: description, start_time: start_time,
                                                                 end_time: end_time, where: where, total_cost: total_cost}}
    end

  end
end
