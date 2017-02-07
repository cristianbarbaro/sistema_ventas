module ArticlesHelper
    def get_providers(article_id)
        Article.find(article_id).providers
    end

    def get_category_name(category_id)
        Category.find(category_id).name
    end

    def get_mark_name(mark_id)
        Mark.find(mark_id).name
    end

    def get_final_price(article_id)
      ActionController::Base.helpers.number_with_precision(Article.find(article_id).final_price, precision: 2, separator: '.')
    end

    def get_cost_price(article_id)
      ActionController::Base.helpers.number_with_precision(Article.find(article_id).cost_price, precision: 2, separator: '.')
    end
end
