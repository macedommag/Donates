class SessionsController < ApplicationController
  def new
  end

  def create
    user = Donor.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to institutions_path(format: :json), notice: 'Login bem-sucedido!'
    else
      flash.now[:alert] = 'Email ou senha inválidos'
      render :new
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logout realizado com sucesso!'
  end
end
