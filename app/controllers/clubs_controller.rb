class ClubsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :club_exists, only: [:show, :edit, :update]

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
end
