class Line < ApplicationRecord
    belongs_to :articles
    belongs_to :sales

    validates :sale_id, :article_id, :article_amount, :article_final_price_unit, presence: true
end
