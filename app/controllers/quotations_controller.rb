class QuotationsController < ApplicationController
  before_action :authenticate_user!, except: %i[show create]
  before_action :set_quotation, only: %i[show update]
  load_and_authorize_resource

  def index
    @quotations = Quotation.all
    @quotations = Quotation.by_status(status) if status

    json_response @quotations
  end

  def show
    json_response @quotation
  end

  def create
    @quotation = Quotation.new(quotation_params)

    if @quotation.save
      json_response @quotation, :created
    else
      error_response @quotation
    end
  end

  def update
    if @quotation.update(quotation_params)
      json_response @quotation
    else
      error_response @quotation
    end
  end

  private

  def status
    params[:status]
  end

  def set_quotation
    @quotation = Quotation.find params[:id]
  end

  def quotation_params
    params.require(:quotation).permit(
      :group_size,
      :user_email,
      :status,
      :date,
      :custom_email_message,
      activity_ids: [],
      price_ids: []
    )
  end
end
