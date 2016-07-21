class Article < ApplicationRecord
    belongs_to :category
    belongs_to :mark
    has_one :stock, inverse_of: :article, dependent: :destroy
    has_many :historics, dependent: :destroy
    has_many :sale_lines
    has_many :sales, through: :sale_lines
    has_and_belongs_to_many :providers

    accepts_nested_attributes_for :providers
    accepts_nested_attributes_for :stock, allow_destroy: true
    validates :code, :name, :cost_price, :percentage, :description, :mark_id, :category_id, presence: true
    validates_uniqueness_of :code

    def get_public_price
        (self.cost_price * self.percentage / 100 ) + self.cost_price
    end
end
