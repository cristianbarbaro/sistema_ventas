class Article < ApplicationRecord
    belongs_to :category
    belongs_to :mark
    has_one :stock
    has_many :historics
    has_many :lines
    has_many :sales, through: :lines
    has_and_belongs_to_many :providers

    validates :name, :cost_price, :percentage, :description, :mark_id, :category_id, presence: true
end
