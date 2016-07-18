class Historic < ApplicationRecord
    belongs_to :article

    validates :article_id, :cost_price, presence: true
end
