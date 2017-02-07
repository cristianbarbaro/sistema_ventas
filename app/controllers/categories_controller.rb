class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def index
        @q = Category.ransack(params[:q])
        @categories = @q.result.paginate(:page => params[:page]).order(sort_column + " " + sort_direction)
    end

    def show
    end

    def new
        @category = Category.new
    end

    def edit
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = 'La categoría se ha actualizado exitosamente.'
            redirect_to @category
        else
            render :edit
        end
    end

    def update
        if @category.update(category_params)
            flash[:success] = 'La categoría se ha actualizado correctamente.'
            redirect_to @category
        else
            render :edit
        end
    end

    def destroy
        if @category.destroy
            flash[:success] = 'La categoría se ha eliminado exitosamente.'
        else
            flash[:alert] = 'No se puede eliminar la categoría porque tiene artículos asociados.'
        end
        redirect_to categories_url
    end

    private
        def category_params
            params.require(:category).permit(:name)
        end

        def set_category
            @category = Category.find(params[:id])
        end

        def sort_column
          Category.column_names.include?(params[:sort]) ? params[:sort] : "name"
        end
end
