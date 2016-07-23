class Mark < ApplicationRecord
    has_many :articles, dependent: :restrict_with_error

    validates :name, presence: true
    validates_uniqueness_of :name
end
