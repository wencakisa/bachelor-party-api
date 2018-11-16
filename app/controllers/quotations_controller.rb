class QuotationsController < ApplicationController
  before_action :authenticate_user!, except: %i[show create]
  before_action :set_quotation, only: %i[show update]
  load_and_authorize_resource

  include Response

  def index
    @quotations = Quotation.all

    @quotations = @quotations.where(status: params[:status]) if params[:status]

    json_response @quotations
  end

  def show
    json_response @quotation
  end

  def create
    @quotation = Quotation.create!(quotation_params)
    json_response @quotation
  end

  def update
    @quotation.update(quotation_params)
    json_response @quotation
  end

  private

  def set_quotation
    @quotation = Quotation.find params[:id]
  end

  def quotation_params
    params.require(:quotation).permit(
      :group_size,
      :user_email,
      activity_ids: []
    )
  end
end
