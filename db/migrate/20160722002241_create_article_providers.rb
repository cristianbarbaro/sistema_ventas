class CreateArticleProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :article_providers do |t|
        t.belongs_to :article, index: true
        t.belongs_to :provider, index: true
        t.timestamps
    end
  end
end
