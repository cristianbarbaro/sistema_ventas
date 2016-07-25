class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    helper ArticlesHelper

    def index
        respond_to do |format|
            format.html {
                if not params[:search].nil?
                    @articles = Article.search(params[:search]).paginate(:page => params[:page]).order(:name)
                else
                    @articles = Article.paginate(:page => params[:page]).order(:name)
                end
            }
            format.json {
                # En formato JSON, verifico si se realiza consulta por el código de barra,
                # sino es así, retorno todos los artículos como se hiciera por defecto. ¿Es esta la mejor solución?
                if not params[:q].nil?
                    @article = Article.find_by(code: params[:q])
                    if @article.nil?
                        render json: {errors: :not_found!}, status: :unprocessable_entity
                    else
                        @article
                    end
                else
                    @articles = Article.paginate(:page => params[:page]).order(:name)
                end
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
            create_historic
            flash[:success] = 'El artículo se ha creado exitosamente.'
            redirect_to @article
        else
            render :edit
        end
    end

    def update
        old_price = @article.cost_price
        if @article.update(article_params)
            # @article.historics.create!({cost_price: params.require(:article)[:cost_price], article_id: @article.id})
            if old_price != @article.cost_price
                create_historic
            end
            flash[:success] = 'El artículo se ha actualizado correctamente.'
            redirect_to @article
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

        def create_historic
            # Active Model Dirty before save (don't works after).
            @article.historics.create({cost_price: params.require(:article)[:cost_price]})
        end
end
