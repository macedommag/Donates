class ApplicationController < ActionController::Base
  def authenticate_user
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?
    begin
      decoded_token = JWT.decode(token, Rails.application.secret_key_base)
      @current_user = User.find(decoded_token[0]['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Unauthorized' }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :unauthorized
    end
  end
end
