class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items

  validates :table_number, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending preparing ready delivered cancelled] }
end
