class SalesController < ApplicationController
    def new
        @sale = Sale.new
        @sale.sale_lines.build
    end

    def create
        @sale = Sale.new(sales_params)
        if @sale.save!
            flash[:success] = 'La venta se ha guardado exitosamente.'
            redirect_to :root
        else
            flash[:errors] = "Hubo errores al intentar guardar la venta."
            redirect_to :edit
        end
    end

    private
        def sales_params
            params.require(:sale).permit(:total_price,
                sale_lines_attributes: [:id, :article_id, :article_amount, :article_final_price_unit])
        end
end
