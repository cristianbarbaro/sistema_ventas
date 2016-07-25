require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
    setup do
        @category_one = categories(:one)
        @category_three = categories(:three) # No associated with articles.
        @art_one = articles(:one) # Associated with mark_one.
    end

    test "should not save category without data" do
        category = Category.new
        assert_not category.save
    end

    test "should save category with correct data" do
        category = Category.create({
                name: "new"
            })
        assert category.save
    end

    test "should not save category if name exists in another category" do
        category = Category.create({
                name: "one"
            })
        assert_not category.save
    end

    test "should not destroy category with associated articles" do
        assert_not @category_one.destroy
    end

    test "should destroy category without associated articles" do
        assert @category_three.destroy
    end
end
