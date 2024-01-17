class User < ApplicationRecord
  devise :database_authenticatable, :validatable

  has_many :incomes, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :income_categories, dependent: :destroy
  has_many :payment_categories, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
