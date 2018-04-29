class ActivitiesController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show, :edit, :update, :attend, :quit]
  before_action only: [:index, :new, :create] do
    club_exists(params[:club_id])
  end
  before_action :activity_exists, only: [:show, :edit, :update, :attend, :quit, :cancel, :complete]
  before_action only: [:edit, :update, :cancel, :complete] do
    club_exists(@activity.club.id)
  end
  before_action :club_admin, only: [:new, :create, :edit, :update, :cancel, :complete] # TODO: :edit, :cancel is not working
  before_action only: [:attend, :quit] do
    redirect_to(root_url) unless user_in_club?(current_user, @activity.club)
  end

  def index
    #TODO show upcoming activities and cancelled/finished activities in seperate tabs using Bootstrap nav nav-tabs
    @activities = Activity.where(club_id: params[:club_id]).paginate(page: params[:page])
  end

  def new
    @activity = Activity.new  # TODO: auto-fill the End time based on Start time (default 1 hour duration)
    # TODO: pre-fill the Where based on last activity, or even better, auto-complete the Where based on historic places
  end

  def create
    @activity = @club.activities.build(activity_params)
    if @activity.save
      flash[:success] = 'Activity created!'
      redirect_to @activity
    else
      render 'new'
    end
  end


  def show
    @players = @activity.players
  end

  def edit

  end

  def update
    if @activity.update_attributes(activity_params)
      # Handle a successful update.
      flash[:success] = 'Activity info updated'
      redirect_to @activity
    else
      render 'edit'
    end
  end

  def attend
    player = @activity.players.build
    player.user = current_user
    player.save
    flash[:success] = 'You are in!'
    redirect_to @activity
  end

  def quit
    player = Player.find_by(user_id: current_user.id, activity_id: @activity.id)
    if player
      player.destroy
      flash[:success] = 'You quited from this activity'
    end
    redirect_to @activity
  end

  def cancel
    # for now, just mark the status of the activity to "cancelled"
    @activity.update_attributes(status: 'cancelled')
    flash[:success] = 'This activity is now cancelled'
    redirect_to @activity
  end

  def complete
    players = @activity.players
    if players.empty?
      flash[:warning] = "An activity without players can't be marked as completed"
    else
      @activity.update_attributes(status: 'completed')
      average_cost = (@activity.total_cost.to_f / players.count).round(2)
      players.each do |player|
        player.update_attributes(cost: average_cost)
        member = Member.find_by(user_id: player.user.id, club_id: @activity.club.id)
        new_balance = member.balance - average_cost
        member.update_attributes(balance: new_balance)
      end
      flash[:success] = "This activity is now completed, and each player is charged #{average_cost}"
    end
    redirect_to @activity
  end

  private

    def activity_params
      params.require(:activity).permit(:name, :description, :start_time, :end_time, :where, :total_cost)
    end

    def activity_exists
      @activity = Activity.find(params[:id])
      redirect_to(root_url) unless @activity
    end
end
