module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def error_response(object, status = :unprocessable_entity)
    render json: { errors: object.errors.full_messages }, status: status
  end

  def not_found
    permission_error_response 'Not found.', :not_found
  end

  def forbidden
    permission_error_response(
      'You are not authorized to access this page.',
      :forbidden
    )
  end

  private

  def permission_error_response(error_message, status)
    render json: { error: error_message }, status: status
  end
end
