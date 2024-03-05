class Institution < ApplicationRecord
  validates :name, presence: true
  validates :cnpj, presence: true, uniqueness: true, format: { with: /\A\d{2}\.\d{3}\.\d{3}\/\d{4}-\d{2}\z/ }
  validates :bank_account, presence: true
  has_many :donations
  scope :filter_by_name, ->(name) { where('name ILIKE ?', "%#{name}%") if name.present? }
  scope :order_by_name, ->(direction) { order(name: direction) if direction.present? }

  def total_donations
    donations.sum(:amount)
  end
  def self.filtered_and_ordered(params)
    institutions = all
    institutions = institutions.filter_by_name(params[:name]) if params[:name].present?
    institutions = institutions.order_by_name(params[:sort]) if params[:sort].present?
    institutions
  end
end
