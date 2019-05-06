class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::MimeResponds

  include Response

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from CanCan::AccessDenied, with: :forbidden
end
