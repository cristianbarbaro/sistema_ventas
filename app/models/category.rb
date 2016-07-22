class Category < ApplicationRecord
    has_many :providers, dependent: :restrict_with_error
    has_many :articles, dependent: :restrict_with_error

    validates :name, presence: true
    validates_uniqueness_of :name
end
