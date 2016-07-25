require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
    setup do
      # No tiene ventas, caso contrario no permite su borrado. Se testea en modelos.
      @article = articles(:three)
    end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get show" do
    get article_url(@article)
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should get create" do
    assert_difference('Article.count') do
        post articles_url, params: {article: {
            code: 1111,
            name: @article.name,
            cost_price: @article.cost_price,
            percentage: @article.percentage,
            final_price: @article.final_price,
            description: @article.description,
            mark_id: @article.mark_id,
            category_id: @article.category_id,
            stock_attributes: {current_amount: 10, minimum_amount: 0},
            }
        }
    end
    assert_redirected_to article_url(Article.last)
  end

  test "should get update" do
    patch article_url(@article), params: {article: {
            code: 1111,
            name: @article.name,
            cost_price: @article.cost_price,
            percentage: @article.percentage,
            final_price: @article.final_price,
            description: @article.description,
            mark_id: @article.mark_id,
            category_id: @article.category_id,
            stock_attributes: {current_amount: 10, minimum_amount: 0},
            }
        }
    assert_redirected_to article_url(@article)
  end

  test "should get destroy" do
    assert_difference('Article.count', -1) do
        delete article_url(@article)
    end
    assert_redirected_to articles_path
  end

end
