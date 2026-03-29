class Shop < ApplicationRecord
  has_one :address, as: :owner, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :cnpj, presence: true, uniqueness: true
end
