class InstitutionsController < ApplicationController
  before_action :authenticate_user # Use authenticate_user! ao invés de authenticate_user
  before_action :authorize_admin, only: [:create]
  before_action :authenticate_token


  # outros métodos aqui...
  def index
    @institutions = Institution.page(params[:page]).per(params[:per_page])
    render json: @institutions, meta: pagination_meta(@institutions)
  end

  def show
    @institution = Institution.find(params[:id])
    render json: @institution
    @total_donations = @institution.total_donations
  end

  def update
    @institution = Institution.find(params[:id])
    if @institution.update(institution_params)
      render json: @institution
    else
      render json: @institution.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @institution = Institution.find(params[:id])
    @institution.destroy
    head :no_content
  end

  def create
    @institution = Institution.new(institution_params)

    if @institution.save
      render json: @institution, status: :created
    else
      render json: @institution.errors, status: :unprocessable_entity
    end
  end

  def donations_by_month
    @institution = Institution.find(params[:id])
    @donations_by_month = @institution.donations.group_by_month(:date).sum(:amount)
  end


  private

  def authorize_admin
    unless @current_donor.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end
  def authenticate_token
    token = params[:token]
    unless token && AuthService.valid_token?(token)
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
