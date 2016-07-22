class Article < ApplicationRecord
    belongs_to :category
    belongs_to :mark
    has_one :stock, inverse_of: :article, dependent: :destroy
    has_many :historics, dependent: :destroy
    has_many :sale_lines
    has_many :sales, through: :sale_lines
    has_many :article_providers, dependent: :destroy, inverse_of: :article
    has_many :providers, through: :article_providers

    accepts_nested_attributes_for :article_providers, allow_destroy: true
    accepts_nested_attributes_for :stock, allow_destroy: true
    validates :code, :name, :cost_price, :percentage, :description, :mark_id, :category_id, presence: true
    validates :cost_price, numericality: { greater_than_or_equal_to: 0 }
    validates :percentage, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates_uniqueness_of :code

    def get_public_price
        (self.cost_price * self.percentage / 100 ) + self.cost_price
    end
end
