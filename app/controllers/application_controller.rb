class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include ClubsHelper
  include ActivitiesHelper
  def hello
    render html: "hello, world!"
  end

  private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def club_exists(club_id)
    @club = Club.find(club_id)
    redirect_to(root_url) unless @club
  end

  def club_admin
    admin = get_club_admin(@club)
    redirect_to(root_url) unless current_user?(admin)
  end

end
