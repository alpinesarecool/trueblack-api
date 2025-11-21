module Types
  class MenuItemType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :price, Float, null: true
    field :image_url, String, null: true
    field :is_available, Boolean, null: true
    field :is_veg, Boolean, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
