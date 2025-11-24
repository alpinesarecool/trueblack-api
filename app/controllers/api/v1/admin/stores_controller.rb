module Api
  module V1
    module Admin
      class StoresController < ApplicationController
        # GET /api/v1/admin/stores
        def index
          stores = Store.all
          render json: stores
        end

        # POST /api/v1/admin/stores
        def create
          store = Store.new(store_params)
          if store.save
            NotificationService.new.store_updated(store)
            render json: store, status: :created
          else
            render json: { errors: store.errors }, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /api/v1/admin/stores/:id
        def update
          store = Store.find(params[:id])
          if store.update(store_params)
            NotificationService.new.store_updated(store)
            render json: store
          else
            render json: { errors: store.errors }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/admin/stores/:id
        def destroy
          store = Store.find(params[:id])
          store.destroy
          head :no_content
        end

        private

        def store_params
          params.require(:store).permit(:name, :space_name, :area, :address, :phone, :latitude, :longitude, :hours)
        end
      end
    end
  end
end
