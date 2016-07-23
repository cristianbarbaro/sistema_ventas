class Provider < ApplicationRecord
    has_many :article_providers, dependent: :restrict_with_error
    has_many :articles, through: :article_providers

    validates :name, presence: true
    validates_uniqueness_of :name
end
