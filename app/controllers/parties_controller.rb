class PartiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    @parties = Party.for_user(current_user)

    json_response @parties
  end
end
