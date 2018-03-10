module ActivitiesHelper
  def player?(user, activity)
    player = Player.find_by(user_id: user.id, activity_id: activity.id)
    player ? true : false
  end
end
