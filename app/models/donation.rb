class Donation < ApplicationRecord
  belongs_to :institution

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true
  validate :date_cannot_be_in_the_future

  private

  def date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "não pode estar no futuro")
    end
  end
end
