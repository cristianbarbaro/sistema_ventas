class Article < ApplicationRecord
    belongs_to :category
    belongs_to :mark
    has_one :stock, inverse_of: :article
    has_many :historics
    has_many :lines
    has_many :sales, through: :lines
    has_and_belongs_to_many :providers

    validates :name, :cost_price, :percentage, :description, :mark_id, :category_id, presence: true
    accepts_nested_attributes_for :stock, allow_destroy: true
    validates :code, :name, :cost_price, :percentage, :description, :mark_id, :category_id, presence: true
end
