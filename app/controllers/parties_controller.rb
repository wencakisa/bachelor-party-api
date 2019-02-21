class PartiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    @parties = Party.all

    if current_user.customer?
      @parties = @parties.for_customer_user current_user
    elsif current_user.guide?
      @parties = @parties.for_guide_user current_user
    end

    json_response @parties
  end
end
