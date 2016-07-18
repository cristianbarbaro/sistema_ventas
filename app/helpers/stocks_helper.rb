module StocksHelper
    def get_article(article_id)
        Article.find(article_id)
    end

    def get_difference(stock)
        stock.current_amount - stock.minimum_amount
    end
end
