class ActivitiesController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show, :edit, :update]
  before_action only: [:index, :new, :create] do
    club_exists(params[:club_id])
  end
  before_action :club_admin, only: [:new, :create, :edit, :update]
  before_action :activity_exists, only: [:show, :edit, :update]

  def index
    @activities = Activity.where(club_id: params[:club_id]).paginate(page: params[:page])
  end

  def new
    @activity = Activity.new  # TODO: auto-fill the End time based on Start time (default 1 hour duration)
    # TODO: pre-fill the Where based on last activity, or even better, auto-complete the Where based on historic places
  end

  def create
    @activity = @club.activities.build(activity_params)
    if @activity.save
      flash[:success] = "Activity created!"
      redirect_to @activity
    else
      render 'new'
    end
  end


  def show

  end

  def edit

  end

  def update
    if @activity.update_attributes(activity_params)
      # Handle a successful update.
      flash[:success] = "Activity info updated"
      redirect_to @activity
    else
      render 'edit'
    end
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
