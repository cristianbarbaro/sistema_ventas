class StocksController < ApplicationController
    before_action :set_stock, only: [:edit, :update]
    def index
        @stocks = Stock.paginate(:page => params[:page]).order("current_amount - minimum_amount")
    end

    def edit
    end

    def update
        if @stock.update(stock_params)
            flash[:success] = 'El stock se ha actualizado correctamente.'
            redirect_to return_to_previous_url
        else
            render :index
        end
    end

    private
        def stock_params
            params.require(:stock).permit(:current_amount, :minimum_amount)
        end

        def set_stock
            @stock = Stock.find(params[:id])
        end

end
