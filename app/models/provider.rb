class Provider < ApplicationRecord
    belongs_to :category
    has_many :article_providers
    has_many :articles, through: :article_providers

    validates :name, :category_id, presence: true
    validates_uniqueness_of :name
end
