class Sale < ApplicationRecord
    has_many :sale_lines, inverse_of: :sale
    has_many :articles, through: :sale_lines

    validates :sale_lines, presence: true
    accepts_nested_attributes_for :sale_lines
    validates :total_price, presence: true
end
