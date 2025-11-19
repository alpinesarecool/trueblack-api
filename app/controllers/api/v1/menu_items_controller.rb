module Api
  module V1
    class MenuItemsController < ApplicationController
      def show
        menu_item = MenuItem.find(params[:id])
        render json: menu_item
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Menu item not found' }, status: :not_found
      end
    end
  end
end
