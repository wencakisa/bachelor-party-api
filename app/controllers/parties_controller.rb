class PartiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    if not current_user.admin?
      @parties = current_user.parties
    else
      @partie = Party.all
    end

    json_response @parties
  end
end
