class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    helper ArticlesHelper

    def index
        @articles = Article.paginate(:page => params[:page]).order(:name)
    end

    def show
        @providers = @article.providers
    end

    def new
        @article = Article.new
        @article.build_stock
        @providers = Provider.all
        @article.providers.build
    end

    def edit
        @providers = @article.providers
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
            # Historic.create!({cost_price: params.require(:article)[:cost_price], article_id: @article.id})
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
                                    :mark_id, :category_id, :code,
                                    providers_attributes: [:article_id, :provider_id, :_destroy],
                                    stock_attributes: [:id, :article_id, :current_amount, :minimum_amount])
        end

        def stock_params
            params.require(:stock).permit(:current_stock, :minimum_stock)
        end

        def create_historic
            # Active Model Dirty before save (don't works after).
            Historic.create!({cost_price: params.require(:article)[:cost_price], article_id: @article.id})
        end
end
