module ClubsHelper
  def get_club_admin(club)
    #member = Club.joins(:members).where(members:{club_id: club.id, admin:true})
    #Member.joins(:clubs)
    member_admin = Member.where(club_id: club.id, admin:true).first # there should be one and only one admin for each club
    admin = User.find_by(id: member_admin.user_id)
  end
end
