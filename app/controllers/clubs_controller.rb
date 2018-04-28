class ClubsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy, :join, :members]
  before_action only: [:show, :edit, :update, :join, :members, :pay] do
    club_exists(params[:id])
  end
  before_action :club_admin, only: [:edit, :update]
  #before_action :user_in_club, only: [:members]

  def index
    # TODO use Bootstrap thumbnails with custom content to show clubs in grids
    @clubs = Club.all.paginate(page: params[:page])
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

  # show all club members
  def members
    @club_members = Member.where(club_id: @club.id).paginate(page: params[:page])
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

  def join # join a club as a member
    # make sure the current user is not already in this club
    user = current_user
    member_exist = Member.find_by(user_id: user.id, club_id: @club.id) # TODO: test can't join the same club twice
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

  def pay
    payment = Payment.new(payment_params)
    payment.save
    member = payment.member
    member_balance = member.balance + payment.amount
    member.update_attribute(:balance, member_balance)
    redirect_to members_club_path(@club)
  end

  def destroy

  end

  private

  def club_params
    #debugger
    params.require(:club).permit(:name, :description)
  end

  def payment_params
    params.require(:payment).permit(:member_id, :amount)
  end

  def user_in_club
    redirect_to(root_url) unless user_in_club?(current_user, @club)
  end
end
