if not @articles.nil?
    json.array!(@articles) do |article|
      json.extract! article, :id, :name, :code, :description, :cost_price, :percentage, :mark_id, :category_id
      json.url article_url(article, format: :json)
    end
elsif not @article.nil?
    json.extract! @article, :id, :name, :code, :description, :cost_price, :percentage, :mark_id, :category_id
end
