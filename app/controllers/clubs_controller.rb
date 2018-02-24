class ClubsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy, :my, :join, :members]
  #before_action :correct_user, only: [:my]
  before_action :club_exists, only: [:show, :edit, :update, :join, :members]
  before_action :club_admin, only: [:edit, :update]
  before_action :user_in_club, only: [:members]

  def index
    @clubs = Club.all.paginate(page: params[:page])
  end

  def my
    user = current_user
    @my_clubs = Club.joins(:members).where(members: {user_id: user.id}).paginate(page: params[:page])
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    if @club.save
      # the creator of the club will become a member of it as admin automatically
      member = Member.new
      member.user = current_user
      member.club = @club
      member.admin = true
      member.save

      flash[:info] = "The club is successfully created."
      redirect_to @club
    else
      render 'new'
    end
  end

  def show
  end

  def members
    @club_members = Member.where(club_id: @club.id).paginate(page: params[:page])
  end

  # TODO: show members of a club

  def edit
  end

  def update
    if @club.update_attributes(club_params)
      # Handle a successful update.
      flash[:success] = "Club info updated"
      redirect_to @club
    else
      render 'edit'
    end
  end

  def join
    # make sure the current user is not already in this club
    user = current_user
    member_exist = Member.find_by(user_id: user.id, club_id: @club.id)
    if member_exist
      flash[:warning] = 'You are already in this club'
    else
      member = Member.new
      member.user = user
      member.club = @club
      member.save

      flash[:success] = 'You joined this club.'
    end
    redirect_to @club
  end

  def destroy

  end

  private

  def club_params
    #debugger
    params.require(:club).permit(:name, :description)
  end

  def club_exists
    @club = Club.find(params[:id])
    redirect_to(root_url) unless @club
  end

  def club_admin
    admin = get_club_admin(@club)
    redirect_to(root_url) unless current_user?(admin)
  end

  def user_in_club
    redirect_to(root_url) unless user_in_club?(current_user, @club)
  end
end
