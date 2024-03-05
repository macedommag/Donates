class DonationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_institution
  before_action :set_donation, only: [:update, :destroy]
  before_action :authorize_user!, only: [:update, :destroy]

  # POST /institutions/:institution_id/donations
  def create
    if @institution.donations.exists?(user_id: current_user.id)
      render json: { error: 'Você já fez uma doação para esta instituição' }, status: :unprocessable_entity
      return
    end

    @donation = @institution.donations.new(donation_params.merge(user_id: current_user.id))

    if @donation.save
      # Configuração do cliente da API
      client = CoinbaseCommerce::Client.new(api_key: API_KEY)

      # Criação da cobrança
      charge = client.charge.create(
        name: "Nome do Produto",
        description: "Descrição do Produto",
        local_price: {
          amount: amount,
          currency: "USD"
        },
        pricing_type: "fixed_price"
      )

      # Você pode acessar os detalhes da cobrança assim:
      puts "ID da Cobrança: #{charge.id}"
      puts "Status da Cobrança: #{charge.status}"

      # Notificar por e-mail
      NotificationMailer.new_donation_notification(@donation).deliver_now

      # Notificar por WhatsApp
      WhatsappService.new.send_notification('+1234567890', 'Nova doação recebida')

      render json: @donation, status: :created
    else
      render json: @donation.errors, status: :unprocessable_entity
    end
  end




  # GET /institutions/:institution_id/donations
  def index
    @donations = @institution.donations
    render json: @donations
  end

  # GET /institutions/:institution_id/donations/:id
  def show
    @donation = @institution.donations.find(params[:id])
    render json: @donation
  end

  # PATCH/PUT /institutions/:institution_id/donations/:id
  def update
    if @donation.update(donation_params)
      render json: @donation
    else
      render json: @donation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /institutions/:institution_id/donations/:id
  def destroy
    @donation.destroy
    head :no_content
  end

  def new
    if params[:institution_id]
      @institution = Institution.find(params[:institution_id])
      @donation = @institution.donations.new
    else
      @donation = Donation.new
    end
  end

  private

  def set_institution
    @institution = Institution.find(params[:institution_id])
  end

  def set_donation
    @donation = @institution.donations.find(params[:id])
  end

  def authorize_user!
    unless @donation.user == current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def donation_params
    params.require(:donation).permit(:amount, :date)
  end
end
