module Api
  module V1
    module Admin
      class MenuItemsController < ApplicationController
        # GET /api/v1/admin/menu_items
        def index
          menu_items = MenuItem.includes(:category).all
          render json: menu_items.as_json(include: { category: { include: :store } })
        end

        # POST /api/v1/admin/menu_items
        def create
          menu_item = MenuItem.new(menu_item_params)
          if menu_item.save
            NotificationService.new.menu_item_updated(menu_item)
            render json: menu_item, status: :created
          else
            render json: { errors: menu_item.errors }, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /api/v1/admin/menu_items/:id
        def update
          menu_item = MenuItem.find(params[:id])
          if menu_item.update(menu_item_params)
            NotificationService.new.menu_item_updated(menu_item)
            render json: menu_item
          else
            render json: { errors: menu_item.errors }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/admin/menu_items/:id
        def destroy
          menu_item = MenuItem.find(params[:id])
          menu_item.destroy
          head :no_content
        end

        private

        def menu_item_params
          params.require(:menu_item).permit(:name, :price, :description, :category_id, :is_available, :is_veg, :image_url)
        end
      end
    end
  end
end
