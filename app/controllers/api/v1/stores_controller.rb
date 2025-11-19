module Api
  module V1
    class StoresController < ApplicationController
      def index
        stores = Store.all
        render json: stores
      end

      def show
        store = Store.find(params[:id])
        render json: store, include: { categories: { include: :menu_items } }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Store not found' }, status: :not_found
      end
    end
  end
end
