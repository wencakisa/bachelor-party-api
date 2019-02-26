module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def error_response(object, status = :unprocessable_entity)
    render json: { errors: object.errors.full_messages }, status: status
  end
end
