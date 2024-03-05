class Donor < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :donations
  has_secure_password

  def total_donations
    donations.sum(:amount)
  end

end
