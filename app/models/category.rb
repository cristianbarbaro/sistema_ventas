class Category < ApplicationRecord
    has_many :providers
    has_many :articles

    validates :name, presence: true
    validates_uniqueness_of :name
end
