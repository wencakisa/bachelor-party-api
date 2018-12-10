class ActivitiesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_activity, only: %i[show update destroy]
  load_and_authorize_resource

  include Response

  def index
    @activites = Activity.all
    @activities = @activities.where(time_type: params[:time_type]) if params[:time_type]

    json_response @activites
  end

  def show
    json_response @activity
  end

  def create
    @activity = Activity.create!(activity_params)
    json_response @activity
  end

  def update
    @activity.update(activity_params)
    json_response @activity
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
      prices_attributes: [:id, :amount, :options]
    )
  end
end
