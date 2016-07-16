module ProvidersHelper
    def get_category_name(category_id)
        Category.find(category_id).name
    end
end
