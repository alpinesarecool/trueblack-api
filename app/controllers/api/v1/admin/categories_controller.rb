module Api
  module V1
    module Admin
      class CategoriesController < ApplicationController
        # GET /api/v1/admin/categories
        def index
          categories = Category.includes(:store).all
          render json: categories.as_json(include: :store)
        end

        # POST /api/v1/admin/categories
        def create
          category = Category.new(category_params)
          if category.save
            render json: category, status: :created
          else
            render json: { errors: category.errors }, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /api/v1/admin/categories/:id
        def update
          category = Category.find(params[:id])
          if category.update(category_params)
            render json: category
          else
            render json: { errors: category.errors }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/admin/categories/:id
        def destroy
          category = Category.find(params[:id])
          category.destroy
          head :no_content
        end

        private

        def category_params
          params.require(:category).permit(:name, :store_id)
        end
      end
    end
  end
end
