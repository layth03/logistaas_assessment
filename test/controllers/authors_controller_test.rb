require "test_helper"

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @author = Author.create!(
      name: "Controller Test Author",
      email: "controller@example.com",
      password: "123456"
    )
  end

  test "should redirect unauthenticated author" do
    get authors_url

    assert_redirected_to new_author_session_url
  end

  test "should get index when logged in" do
    sign_in @author

    get authors_url

    assert_response :success
  end
end