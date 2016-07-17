class Stock < ApplicationRecord
    belongs_to :article, inverse_of: :stock
    validates_presence_of :article

    validates :current_amount, :minimum_amount, presence: true
end
