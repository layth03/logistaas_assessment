require "test_helper"

class AuthorTest < ActiveSupport::TestCase
  test "name must be present" do
    author = Author.new(
      name: nil,
      email: "test@example.com",
      password: "123456"
    )

    assert_not author.valid?
  end

  test "name must be unique" do
    Author.create!(
      name: "Unique Test Name",
      email: "author1@example.com",
      password: "123456"
    )

    author = Author.new(
      name: "Unique Test Name",
      email: "author2@example.com",
      password: "123456"
    )

    assert_not author.valid?
  end
end