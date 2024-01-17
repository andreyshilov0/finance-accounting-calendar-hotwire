class Income < ApplicationRecord
  belongs_to :income_category, optional: true
  belongs_to :user

  validates :date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
