class QuotationsController < ApplicationController
  before_action :authenticate_user!, except: %i[show create]
  before_action :set_quotation, only: %i[show update]
  load_and_authorize_resource

  def index
    @quotations = Quotation.all

    if params[:status]
      @quotations = Quotation.by_status(params[:status])
    end

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
      :status,
      :date,
      activity_ids: [],
      price_ids: []
    )
  end
end
