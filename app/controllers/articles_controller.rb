class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :set_return_to_previous_url, only: [:show, :edit, :update_prices, :index]
    before_action :authorized_admin, except: [:index]
    helper ArticlesHelper

    def index
        respond_to do |format|
            format.html {
                @q = Article.ransack(params[:q])
                @articles  = @q.result.includes(:mark, :category).page(params[:page]).order(:name)
            }
            format.json {
                # En formato JSON, verifico si se realiza consulta por el código de barra (usado en el index de Sales),
                # sino es así, retorno todos los artículos como se hiciera por defecto. ¿Es esta la mejor solución?
                if not params[:q].nil?
                    @article = Article.find_by(code: params[:q])
                    if @article.nil?
                        render json: {errors: :not_found!}, status: :unprocessable_entity
                    else
                        @article
                    end
                else
                    @articles = get_articles
                end
            }
            format.pdf {
              @articles = get_articles
            }
        end
    end

    def show
    end

    def new
        @article = Article.new
        @article.build_stock
        @providers = Provider.all
        @article.article_providers.build
    end

    def edit
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            @article.create_historic params.require(:article)[:cost_price]
            flash[:success] = 'El artículo se ha creado exitosamente.'
            redirect_to @article
        else
            render :edit
        end
    end

    def update
        @old_cost_price = @article.cost_price
        @old_percentage = @article.percentage
        @old_final_price = @article.final_price
        if @article.update(article_params)
            # @article.historics.create!({cost_price: params.require(:article)[:cost_price], article_id: @article.id})
            if article_prices_changed?
                @article.create_historic params.require(:article)[:cost_price]
            end
            flash[:success] = 'El artículo se ha actualizado correctamente.'
            redirect_to return_to_previous_url
        else
            render :edit
        end
    end

    def destroy
        if @article.destroy
            flash[:success] = 'El artículo se ha borrado correctamente.'
        else
            flash[:alert] = 'Hubo errores al intentar borrar artículo.'
        end
        redirect_to articles_url
    end

    # GET /update_prices
    def update_prices
        @articles = get_articles
    end

    # POST /update_prices
    def update_prices_post
        percentage = params[:percentage].to_f
        ids_array = params[:article_id]
        ids_array.each do |id|
          a = Article.find(id)
          old_price = a.cost_price
          a.cost_price = ( old_price * percentage / 100 ) + old_price
          final_price = (a.cost_price * a.percentage / 100) + a.cost_price
          a.final_price = final_price.round
          a.save
          # Creamos el histórico de precios
          if old_price != a.cost_price
              a.create_historic(a.cost_price)
          end
        end
        length = ids_array.length
        flash[:success] = "Los precios de los #{length} productos se han actualizado correctamente."
        redirect_to return_to_previous_url
    end

    private
        def set_article
            @article = Article.find(params[:id])
        end

        def article_params
            params.require(:article).permit(:name, :cost_price, :percentage, :description,
                                    :mark_id, :category_id, :code, :final_price,
                                    article_providers_attributes: [:id, :article_id, :provider_id, :_destroy],
                                    stock_attributes: [:id, :article_id, :current_amount, :minimum_amount])
        end

        def article_prices_changed?
          if @old_cost_price != @article.cost_price or @old_percentage != @article.percentage or @old_final_price != @article.final_price
            true
          else
            false
          end
        end

        def get_articles
          @q = Article.ransack(params[:q])
          @q.result.includes(:mark, :category).order(:name)
        end

end
