class Article < ApplicationRecord
    belongs_to :category
    belongs_to :mark
    has_one :stock, inverse_of: :article, dependent: :destroy
    has_many :historics, dependent: :destroy, inverse_of: :article
    has_many :sale_lines, dependent: :restrict_with_error
    has_many :sales, through: :sale_lines
    has_many :article_providers, dependent: :destroy, inverse_of: :article
    has_many :providers, through: :article_providers

    accepts_nested_attributes_for :article_providers, allow_destroy: true
    accepts_nested_attributes_for :stock, reject_if: :all_blank
    validates_presence_of :stock
    # accepts_nested_attributes_for :historics, reject_if: :all_blank
    # validates_presence_of :historics, on: :create
    validates :code, :name, :cost_price, :percentage, :mark_id, :category_id, presence: true
    validates :cost_price, numericality: { greater_than_or_equal_to: 0 }
    validates :final_price, numericality: { greater_than_or_equal_to: 0 }
    validates :percentage, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :code, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates_uniqueness_of :code

    def self.search(search)
        self.where(
            "code = ? or name LIKE ? or description LIKE ?", search, "%#{search}%", "%#{search}%")
    end

    def create_historic(new_cost_price)
        self.historics.create({cost_price: new_cost_price})
    end

    def last_update_price()
      self.historics.last.created_at
    end

    private
        # Convierto codigo en string para poder buscar en Ransack usando LIKE de SQL.
        ransacker :code do
            Arel.sql("CONVERT(#{table_name}.code, CHAR(14))")
        end

end
