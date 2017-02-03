class Historic < ApplicationRecord
    belongs_to :article, inverse_of: :historics

    validates_presence_of :article
    validates :cost_price, presence: true
    validates :cost_price, numericality: { greater_than_or_equal_to: 0 }

    def cost_price
      ActionController::Base.helpers.number_with_precision(self[:cost_price], precision: 2, separator: '.') || self[:cost_price]
    end
end
