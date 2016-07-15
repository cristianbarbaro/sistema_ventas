class Sale < ApplicationRecord
    has_many :lines
    has_many :articles, through: :lines

    validates :total_price, presence: true
end
