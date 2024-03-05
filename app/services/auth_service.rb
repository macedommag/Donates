class AuthService
  def self.generate_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.secret_key_base)
  end
end
