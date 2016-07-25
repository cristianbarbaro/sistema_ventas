require 'test_helper'

class ProvidersControllerTest < ActionDispatch::IntegrationTest
    setup do
        @provider = providers(:three)
    end

    test "should get index" do
        get providers_url
        assert_response :success
    end

    test "should get show" do
        get providers_url(@provider)
        assert_response :success
    end

    test "should get new" do
        get new_provider_url
        assert_response :success
    end

    test "should get edit" do
        get edit_provider_url(@provider)
        assert_response :success
    end

    test "should get create" do
        assert_difference('Provider.count') do
            post providers_url, params: { provider: {
                name: :four,
                contact: :stringFour,
                }
            }
        end
        assert_redirected_to provider_url(Provider.last)
    end

    test "should get update" do
        patch provider_url(@provider), params: { provider: {
            name: :four
            }
        }
        assert_redirected_to provider_url(@provider)
    end

    test "should get destroy" do
        assert_difference('Provider.count', -1) do
            delete provider_url(@provider)
        end
        assert_redirected_to providers_url
    end

end
