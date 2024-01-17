class IncomeCategory < ApplicationRecord
  belongs_to :user
  has_many :incomes, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
