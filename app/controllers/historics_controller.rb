class HistoricsController < ApplicationController
    before_action :authorized_admin
    # GET /articles/1/historics
    def index
      @historics = Historic.where(article_id: params[:article_id]).paginate(:page => params[:page]).order('created_at DESC')
    end

    def get_article(id)
        Article.find(id)
    end
end
