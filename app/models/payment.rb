class Payment < ApplicationRecord
  belongs_to :payment_category, optional: true
  belongs_to :user

  validates :date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
