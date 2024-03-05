class DonorsController < ApplicationController
  # outros métodos aqui...
  def index
    @donors = Donor.all
    render json: @donors
  end

  def show
    @donor = Donor.find(params[:id])
    render json: @donor
    @total_donations = @donor.total_donations
  end

  def create
    @donor = Donor.new(donor_params)

    if @donor.save
      render json: @donor, status: :created
    else
      render json: @donor.errors, status: :unprocessable_entity
    end
  end

  def update
    @donor = Donor.find(params[:id])
    if @donor.update(donor_params)
      render json: @donor
    else
      render json: @donor.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @donor = Donor.find(params[:id])
    @donor.destroy
    head :no_content
  end

  private

  def donor_params
    params.require(:donor).permit(:name, :email)
  end
end
