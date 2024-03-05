class RegistrationsController < ApplicationController
  def new
    @donor = Donor.new
  end

  def create
    puts "Params received: #{params.inspect}" # Adicione esta linha para verificar os parâmetros recebidos

    @donor = Donor.new(user_params)
    if @donor.save
      puts "Doador salvo com sucesso: #{@donor.inspect}" # Adicione esta linha para verificar se o doador foi salvo com sucesso
      # Redirecionar para algum lugar após o cadastro bem-sucedido
    else
      puts "Erro ao salvar o doador: #{@donor.errors.full_messages}"
      render :new
    end
  end

  private

  def user_params
    params.require(:donor).permit(:name, :email, :password, :password_confirmation) # Alteração aqui
  end
end
