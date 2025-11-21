class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items

  validates :table_number, presence: true
end
