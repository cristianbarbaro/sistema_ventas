class Provider < ApplicationRecord
    belongs_to :category
    has_and_belongs_to_many :articles

    validates :name, :category_id, presence: true
    validates_uniqueness_of :name
end
