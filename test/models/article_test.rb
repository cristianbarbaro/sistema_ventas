require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
    setup do
        @article_one = articles(:one) # In a sale
        @category_one = categories(:one)
        @mark_one = marks(:one)
        @article_three = articles(:three) # Not sold
    end
    # Analizar casos con historico (se tienen que eliminar también)
    # Analizar casos con su misma creacion y ver qué pasa si no recibe categoría, etc.

    test "should not save article without data" do
        article = Article.new
        assert_not article.save
    end

    # Casos de stocks.
    test "should save article with correct data" do
        article = Article.create({
                code: 1111,
                name: "new",
                description: "String",
                cost_price: 10,
                percentage: 30,
                final_price: 13,
                category_id: @category_one.id,
                mark_id: @mark_one.id,
                stock_attributes: {minimum_amount: 10, current_amount: 20},
                # historics_attributes: {'0' => {cost_price: 10}},
            })
        assert article.save
    end

    test "should not save article with incorrect data" do
        article = Article.create({
                code: 1111,
                name: "new",
                description: "String",
                cost_price: "",
                percentage: 30,
                final_price: 13,
                category_id: @category_one.id,
                mark_id: @mark_one.id,
                stock_attributes: {minimum_amount: 10, current_amount: 20}
            })
        assert_not article.save
    end

    # test "should not save article without stocks attributes" do
    #     article = Article.create({
    #             code: 1111,
    #             name: "new",
    #             description: "String",
    #             cost_price: 10,
    #             percentage: 30,
    #             final_price: 13,
    #             category_id: @category_one.id,
    #             mark_id: @mark_one.id,
    #             historics_attributes: {'0' => {cost_price: 10}},
    #         })
    #     assert_not article.save
    # end

    # test "should save article without historics data" do
    #     article = Article.create({
    #             code: 1111,
    #             name: "new",
    #             description: "String",
    #             cost_price: 10,
    #             percentage: 30,
    #             final_price: 13,
    #             category_id: @category_one.id,
    #             mark_id: @mark_one.id,
    #             stock_attributes: {minimum_amount: 10, current_amount: 20},
    #         })
    #     assert_not article.save
    # end

    test "should not save article without correct data in stock" do
        article = Article.create({
                code: 1111,
                name: "new",
                description: "String",
                cost_price: 10,
                percentage: 30,
                final_price: 13,
                category_id: @category_one.id,
                mark_id: @mark_one.id,
                stock_attributes: {minimum_amount: "", current_amount: 20}
            })
        assert_not article.save
    end

    test "should not save article with same code" do
    article = Article.create({
            code: 1001,
            name: "new",
            description: "String",
            cost_price: 10,
            percentage: 30,
            final_price: 13,
            category_id: @category_one.id,
            mark_id: @mark_one.id,
        })
        assert_not article.save
    end


    test "should not destroy article with associated sales" do
        assert_not @article_one.destroy
    end

    test "should destroy article without associated sales" do
        assert @article_three.destroy
    end

end
