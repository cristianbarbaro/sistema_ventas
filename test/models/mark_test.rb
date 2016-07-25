require 'test_helper'

class MarkTest < ActiveSupport::TestCase
    setup do
        @mark_one = marks(:one)
        @mark_three = marks(:three) # No associated with articles.
        @art_one = articles(:one) # Associated with mark_one.
    end

    test "should not save marks without data" do
        mark = Mark.new
        assert_not mark.save
    end

    test "should save marks with correct data" do
        mark = Mark.create({
                name: "new"
            })
        assert mark.save
    end

    test "should not save marks if name exists in another mark" do
        mark = Mark.create({
                name: "one"
            })
        assert_not mark.save
    end

    test "should not destroy mark with associated articles" do
        assert_not @mark_one.destroy
    end

    test "should destroy mark without associated articles" do
        assert @mark_three.destroy
    end

end
