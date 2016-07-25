class Historic < ApplicationRecord
    belongs_to :article, inverse_of: :historics
    
    validates_presence_of :article
    validates :cost_price, presence: true
    validates :cost_price, numericality: { greater_than_or_equal_to: 0 }
end
