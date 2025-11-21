module Api
  module V1
    class OrdersController < ApplicationController
      protect_from_forgery with: :null_session

      # POST /api/v1/orders
      # Expected JSON payload:
      # {
      #   "table_number": "12",
      #   "items": [
      #     {"menu_item_id": 5, "quantity": 2},
      #     {"menu_item_id": 8, "quantity": 1}
      #   ]
      # }
      def create
        order_params = params.permit(:table_number, items: [:menu_item_id, :quantity])
        ActiveRecord::Base.transaction do
          @order = Order.create!(table_number: order_params[:table_number])
          order_params[:items].each do |item|
            menu_item = MenuItem.find(item[:menu_item_id])
            OrderItem.create!(
              order: @order,
              menu_item: menu_item,
              quantity: item[:quantity] || 1,
              price: menu_item.price
            )
          end
        end
        render json: { id: @order.id, created_at: @order.created_at }, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      # GET /api/v1/orders?table_number=12
      def index
        if params[:table_number]
          @orders = Order.where(table_number: params[:table_number]).order(created_at: :desc)
        else
          @orders = Order.all.order(created_at: :desc)
        end
        render json: @orders.as_json(include: { order_items: { include: :menu_item } })
      end
    end
  end
end
