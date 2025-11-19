class Store < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :menu_items, through: :categories

  validates :name, presence: true
end
