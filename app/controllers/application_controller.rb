class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }
  end

  def current_user
    authorize_request
  end

  def authorize_request
    unless @current_user
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
    @current_user
  end

end
