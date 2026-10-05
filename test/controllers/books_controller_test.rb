require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @author = Author.create!(
      name: "Book Owner",
      email: "owner@example.com",
      password: "123456"
    )

    @other_author = Author.create!(
      name: "Other Author",
      email: "other@example.com",
      password: "123456"
    )

    @book = Book.create!(
      name: "Test Book",
      release_date: Date.new(2020, 1, 1),
      author: @author
    )

    sign_in @author
  end

  test "should get index" do
    get books_url

    assert_response :success
  end

  test "should create book for current author" do
    assert_difference("Book.count", 1) do
      post books_url, params: {
        book: {
          name: "New Book",
          release_date: "2021-01-01"
        }
      }
    end

    created_book = Book.find_by!(name: "New Book")

    assert_equal @author.id, created_book.author_id
  end

  test "owner should update book" do
    patch book_url(@book), params: {
      book: {
        name: "Updated Book",
        release_date: "2020-01-01"
      }
    }

    assert_equal "Updated Book", @book.reload.name
  end

  test "other author should not update book" do
    sign_out @author
    sign_in @other_author

    patch book_url(@book), params: {
      book: {
        name: "Hacked Book",
        release_date: "2020-01-01"
      }
    }

    assert_redirected_to books_path
    assert_not_equal "Hacked Book", @book.reload.name
  end

  test "owner should delete book" do
    assert_difference("Book.count", -1) do
      delete book_url(@book)
    end
  end
end