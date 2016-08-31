class SalesController < ApplicationController
    def new
        @sale = Sale.new
        @sale.sale_lines.build
    end

    def index
        if params[:q].nil?
            @q = Sale.ransack(date_created_at_eq: Date.today)
            @sales = @q.result
        else
            @q = Sale.ransack(params[:q])
            @sales = @q.result
        end
        @total_interval = @sales.sum(:total_price)
    end

    def show
        @sale = Sale.find(params[:id])
    end

    def create
        @sale = Sale.new(sales_params)
        if @sale.save!
            flash[:success] = 'La venta se ha guardado exitosamente.'
            redirect_to :root
        else
            flash[:alert] = "Hubo errores al intentar guardar la venta."
            redirect_to :edit
        end
    end

    private
        def sales_params
            params.require(:sale).permit(:total_price,
                sale_lines_attributes: [:id, :article_id, :article_amount, :article_final_price_unit])
        end
end
