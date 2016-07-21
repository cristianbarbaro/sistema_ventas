class SaleLine < ApplicationRecord
    belongs_to :sale, inverse_of: :sale_lines
    belongs_to :article

    validates_presence_of :sale
    validates :article_id, :article_amount, :article_final_price_unit, presence: true
end
