class Historic < ApplicationRecord
    belongs_to :article

    validates :article_id, :discharge_date, :cost_price, presence: true
end
