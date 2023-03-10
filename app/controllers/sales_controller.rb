class SalesController < ApplicationController
    before_action :authorized_admin, only: [:index]

    def new
        @sale = Sale.new
        @sale.sale_lines.build
    end

    def index
        # Cuando se accede a esta página, están vacíos los params, entonces muestro lo del día de la fecha.
        if params[:q].nil?
            @q = Sale.ransack(date_created_at_eq: Date.today.beginning_of_day)
            @sales = @q.result
        # El caso que más importa es cuando comienza a buscar. Necesito saber la fecha de inicio, siendo por defecto, el actual.
        elsif params[:q][:created_at_gt].empty?
            parameters = params[:q]
            parameters[:created_at_gt] = Date.today.beginning_of_day
            @q = Sale.ransack(parameters)
            @sales = @q.result.uniq
            check_category_field params[:q][:sale_lines_article_category_id_eq]
            check_article_field params[:q][:sale_lines_article_id_eq]
        # Cuando hay fecha de inicio, puedo tomar todos los parámetros sin problemas.
        else
          @q = Sale.ransack(params[:q])
          @sales = @q.result.uniq
          check_category_field params[:q][:sale_lines_article_category_id_eq]
          check_article_field params[:q][:sale_lines_article_id_eq]
        end
        #@total_interval = @sales.sum(:total_price)
        @total_interval = @sales.inject(0){ |sum, sale| sum + sale.total_price }
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

        def check_category_field (category_id)
          @category_id = category_id
          if ! @category_id.empty?
              prices_articles = @sales.flat_map { |sale|
                sale.sale_lines.collect { |s|
                  next if s.article.category_id != @category_id.to_i
                    s.article_final_price_unit.to_f * s.article_amount
                }
              }.compact
              if prices_articles.empty?
                @total_per_categories = 0
              else
                @total_per_categories = prices_articles.inject(&:+)
              end
          end

          def check_article_field (article_id)
            @article_id = article_id
            if ! @article_id.empty?
                prices_articles = @sales.flat_map { |sale|
                  sale.sale_lines.collect { |s|
                    next if s.article.id != @article_id.to_i
                      s.article_final_price_unit.to_f * s.article_amount
                  }
                }.compact
                if prices_articles.empty?
                  @total_per_articles = 0
                else
                  @total_per_articles = prices_articles.inject(&:+)
                end
            end
        end

      end
end
