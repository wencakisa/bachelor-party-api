class PartiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_party, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    if not current_user.admin?
      @parties = current_user.parties
    else
      @parties = Party.all
    end

    json_response @parties
  end

  def show
    json_response @party
  end

  def update
    if @party.update(party_params)
      json_response @party
    else
      error_response @party
    end
  end

  def destroy
    @party.destroy
    head :no_content
  end

  private

  def set_party
    @party = Party.find params[:id]
  end

  def party_params
    params.require(:party).permit(:title, :guide_id)
  end
end
