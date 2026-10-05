# LogistaaS Ruby on Rails Assessment

A Ruby on Rails web application where authors can create accounts, log in, browse authors and books, manage their own books, filter records, and export books as CSV.

## Tech Stack

- Ruby 4.0.7
- Rails 8.1.4
- PostgreSQL 18.6
- Devise 5.0.4
- Filterrific 5.2.7
- CSV 3.3.6
- Minitest

## Features

### Authentication

Authentication is handled using Devise.

Authors can:

- Sign up
- Log in
- Log out

### Authors

- View all authors
- Filter authors by name
- Author names must be unique

### Books

Logged-in authors can:

- View all books
- View individual books
- Create books
- Edit their own books
- Delete their own books

Each Book belongs to an Author.

Only the Author who owns a Book can edit or delete it.

### Book Validations

- Book name must be present
- Book name must be unique
- Release date must be present
- Release date cannot be in the future

### Filtering

Filtering is implemented using Filterrific.

Authors can be filtered by:

- Author name

Books can be filtered by:

- Book name
- Release date
- Author name

### CSV Export

The Books index page includes a CSV download option.

The exported CSV contains:

- Book name
- Release date
- Author name

## Project Structure

The application follows the Rails MVC architecture.

### Author Model

The Author model:

- Uses Devise for authentication
- Has many Books
- Validates name presence and uniqueness
- Supports filtering by name

### Book Model

The Book model:

- Belongs to an Author
- Validates name and release date
- Prevents future release dates
- Contains Filterrific scopes for filtering

### BooksController

The BooksController handles:

- Listing books
- Showing individual books
- Creating books
- Updating books
- Deleting books
- Ownership authorization
- Filtering
- CSV export

When a Book is created, the currently logged-in Author is automatically assigned as the owner.

### AuthorsController

The AuthorsController handles:

- Listing authors
- Filtering authors by name

## Testing

The project includes model and controller tests using Rails Minitest.

Tests cover:

- Author name presence
- Author name uniqueness
- Book name uniqueness
- Book release-date validation
- Authentication requirements
- Book creation
- Book updates
- Book deletion
- Book ownership authorization

Run the complete test suite with:

```bash
bin/rails test
```

## Setup

Clone the repository:

```bash
git clone https://github.com/layth03/logistaas_assessment.git
cd logistaas_assessment
```

Install dependencies:

```bash
bundle install
```

Make sure PostgreSQL is installed and running.

Create the database:

```bash
bin/rails db:create
```

Run the migrations:

```bash
bin/rails db:migrate
```

Start the Rails server:

```bash
bin/rails server
```

Then open:

```text
http://localhost:3000
```

## Challenge Faced

### Testing and Fixtures

One of the main challenges I faced was while setting up the automated tests.

Rails was automatically loading fixture data before the tests ran. The generated Author fixtures caused unique email conflicts, and Book fixtures referencing Authors also caused PostgreSQL foreign-key constraint issues.

Since the tests were creating their own data manually, automatic fixture loading was removed. The test database was also reset to remove old fixture records.

A controller test was also improved to find the exact Book created during the test instead of relying on `Book.last`.

This helped make the tests more isolated, predictable, and easier to debug.

## Assessment Time

Start time: October 5, 2026 at 8:10 PM

Break: 9:35 PM - 10:28 PM

End time: October 6, 2026 at 12:29 AM

Total active working time: 3 hours 26 minutes