require 'test_helper'

class ProviderTest < ActiveSupport::TestCase
    setup do
        @art_one = articles(:one)
        @provider_one = providers(:one)
        @provider_three = providers(:three) #No associated with articles.
    end

    test "should not save provider without data" do
        provider = Provider.new
        assert_not provider.save
    end

    test "should save provider with correct data" do
        provider = Provider.create({
                name: "new"
            })
        assert provider.save
    end

    test "should not save provider if name exists in another provider" do
        provider = Provider.create({
                name: "one"
            })
        assert_not provider.save
    end

    test "should not destroy provider with associated articles" do
        assert_not @provider_one.destroy
    end

    test "should destroy provider without associated articles" do
        assert @provider_three.destroy
    end

end
