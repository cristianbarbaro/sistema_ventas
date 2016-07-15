class Stock < ApplicationRecord
    belongs_to :category

    validates :article_id, :current_amount, :minimum_amount, presence: true
end
