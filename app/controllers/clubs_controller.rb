class ClubsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def index
    @clubs = Club.all.paginate(page: params[:page])
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    if @club.save
      flash[:info] = "The club is successfully created."
      redirect_to @club
    else
      render 'new'
    end
  end

  def show
    @club = Club.find(params[:id])
  end

  def destroy

  end

  private

  def club_params
    #debugger
    params.require(:club).permit(:name, :description)
  end
end
