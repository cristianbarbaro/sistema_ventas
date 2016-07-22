class ArticleProvider < ApplicationRecord
    belongs_to :article, inverse_of: :article_providers
    belongs_to :provider
    validates_presence_of :article
    validates :provider_id, presence: true
end
