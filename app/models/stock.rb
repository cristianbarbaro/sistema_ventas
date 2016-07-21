class Stock < ApplicationRecord
    belongs_to :article, inverse_of: :stock
    validates_presence_of :article

    validates :current_amount, :minimum_amount, presence: true
    validates :current_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :minimum_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
