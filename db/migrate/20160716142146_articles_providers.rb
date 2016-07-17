class ArticlesProviders < ActiveRecord::Migration[5.0]
    def change
        create_table :articles_providers, id: false do |t|
            t.belongs_to :article, index: true
            t.belongs_to :provider, index: true
        end
    end
end
