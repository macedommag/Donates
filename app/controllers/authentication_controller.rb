class AuthenticationController < ApplicationController
  def login
    donor = Donor.find_by(email: params[:email])
    if donor&.authenticate(params[:password])
      token = AuthService.generate_token(donor.id)
      redirect_to institutions_path(token: token) # Redirecionamento para a página de instituições com o token
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
