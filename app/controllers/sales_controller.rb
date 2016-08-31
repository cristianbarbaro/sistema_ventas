class SalesController < ApplicationController
    def new
        @sale = Sale.new
        @sale.sale_lines.build
    end

    def index
        ok = true
        # Si tenemos una fecha, validamos también los campos de las horas.
        if not params[:day].nil?
            day = params[:day]
            if not params[:initial_hour].empty? and not params[:final_hour].empty?
                if params[:initial_hour] < params[:final_hour]
                    initial = params[:initial_hour]
                    final = params[:final_hour]
                else
                    flash[:alert] = "Intervalo de horas inválido."
                    ok = false
                end
            else
                flash[:alert] = "Debe ingresar ambos horarios."
                ok = false
            end
        # En el caso de que sea nil (se accede a la página sin parámetros), muestro los valores del día actual:
        else
            day = Date.today
            initial = "00:00"
            final = "23:59"
        end
        if ok
            @sales = Sale.where("date(created_at) = ? and time(created_at) >= ? and time(created_at) <= ?", day, initial, final)
            @total_interval = @sales.sum(:total_price)
        end
        # @q = Sale.ransack(params[:q])
        # @sales = @q.result.paginate(:page => params[:page])

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
