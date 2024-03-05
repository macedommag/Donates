# app/controllers/coinbase_integration_controller.rb

class CoinbaseIntegrationController < ApplicationController
  def test
    # Lógica para autenticar a solicitação com a chave de API privada
    # Lógica para fazer uma solicitação de teste à API da Coinbase Commerce
    # Exemplo: client = CoinbaseCommerce::Client.new(api_key: API_KEY)

    # Lógica para testar a integração com a API da Coinbase Commerce
    render json: { message: 'Integração com a API da Coinbase Commerce testada com sucesso!' }
  end
end
