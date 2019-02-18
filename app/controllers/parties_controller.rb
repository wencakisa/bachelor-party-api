class PartiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    @parties = Party.all

    if not current_user.admin?
      @parties = @parties.for_user current_user
    end

    json_response @parties
  end
end
