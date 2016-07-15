class CategoriesController < ApplicationController
    before_action :set_mark, only: [:show, :edit, :update, :destroy]

    # GET /categories
    def index
      render plain: "hola :)"
    end
end
