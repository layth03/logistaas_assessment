class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  filterrific(
    available_filters: [
      :search_by_name
    ]
  )

  scope :search_by_name, ->(query) {
    where("name ILIKE ?", "%#{query}%")
  }
end