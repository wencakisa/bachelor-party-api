class ActivitiesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_activity, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    @activites = Activity.all

    if params[:time_type]
      @activities = Activity.by_time_type(params[:time_type])
    end

    json_response @activites
  end

  def show
    json_response @activity
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      json_response @activity, :created
    else
      error_response @activity
    end

  end

  def update
    if @activity.update(activity_params)
      json_response @activity
    else
      error_response @activity
    end
  end

  def destroy
    @activity.destroy
    head :no_content
  end

  private

  def set_activity
    @activity = Activity.find params[:id]
  end

  def activity_params
    params.require(:activity).permit(
      :id,
      :title,
      :subtitle,
      :details,
      :transfer_included,
      :guide_included,
      :duration,
      :time_type,
      prices_attributes: %i[id amount options _destroy]
    )
  end
end
