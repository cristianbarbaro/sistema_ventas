class SalesController < ApplicationController

    def new
        @sale = Sale.new
        @sale.sale_lines.build
    end

    def create
        @sale = Sale.new(sales_params)
        # render plain: params.require(:sales)[:sale_lines_attributes].to_hash.inspect
        if @sale.save!
            # create_lines
            flash[:success] = 'La venta se ha guardado exitosamente.'
            redirect_to :back
        else
            redirect_to :edit
        end
    end

    private
        def sales_params
            params.require(:sale).permit(:total_price,
                sale_lines_attributes: [:id, :article_id, :article_amount, :article_final_price_unit])
        end

        def create_lines
            params.require(:sale)[:sale_lines_attributes].to_hash.each do |key, line|
                SaleLine.create!(article_amount: line[:article_amount], article_final_price_unit: line[:article_final_price_unit],
                    sale_id: @sale.id, article_id: line[:article_id])
            end
        end
end
