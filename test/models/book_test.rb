require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "name must be unique" do
    author = Author.create!(
      name: "Test Author",
      email: "author1@example.com",
      password: "123456"
    )

    Book.create!(
      name: "Ruby Guide",
      release_date: Date.new(2020, 1, 1),
      author: author
    )

    book = Book.new(
      name: "Ruby Guide",
      release_date: Date.new(2021, 1, 1),
      author: author
    )

    assert_not book.valid?
  end

  test "release date cannot be in the future" do
    author = Author.create!(
      name: "Future Test Author",
      email: "author2@example.com",
      password: "123456"
    )

    book = Book.new(
      name: "Future Book",
      release_date: Date.current + 1,
      author: author
    )

    assert_not book.valid?
  end

  test "release date must be present" do
    author = Author.create!(
      name: "Date Test Author",
      email: "author3@example.com",
      password: "123456"
    )

    book = Book.new(
      name: "Book Without Date",
      release_date: nil,
      author: author
    )

    assert_not book.valid?
  end
end