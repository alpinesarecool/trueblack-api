module Types
  class StoreType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :address, String, null: true
    field :phone, String, null: true
    field :latitude, Float, null: true
    field :longitude, Float, null: true
    field :space_name, String, null: true
    field :area, String, null: true
    field :hours, String, null: true
    field :categories, [Types::CategoryType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
