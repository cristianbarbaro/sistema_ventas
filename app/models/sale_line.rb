class SaleLine < ApplicationRecord
    belongs_to :sale, inverse_of: :sale_lines
    belongs_to :article

    validates_presence_of :sale
    validates :article_id, :article_amount, :article_final_price_unit, presence: true
    validates :article_amount, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
    validates :article_final_price_unit, numericality: { greater_than_or_equal_to: 0 }
end
