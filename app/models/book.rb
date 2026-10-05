class Book < ApplicationRecord
 belongs_to :author

  validates :name, presence: true, uniqueness: true
  validates :release_date, presence: true
  validate :release_date_cannot_be_in_the_future

  filterrific(
  available_filters: [
    :search_by_name,
    :with_release_date,
    :search_by_author_name
  ]
)

scope :search_by_name, ->(query) {
  where("books.name ILIKE ?", "%#{query}%")
}

scope :with_release_date, ->(date) {
  where(release_date: date)
}

scope :search_by_author_name, ->(query) {
  joins(:author).where("authors.name ILIKE ?", "%#{query}%")
}
  private

  def release_date_cannot_be_in_the_future
    if release_date.present? && release_date > Date.current
      errors.add(:release_date, "cannot be in the future")
    end
  end
end