defmodule Library do
  @moduledoc false
  # the syntax below creates a struct with no default values
  defstruct [:title, :author, :status]

  @doc "Adds a new book to the library with the given title and author, with the status set to :available. Returns the updated library."
  def add_book(library, title, author, status \\ :available) do # default argument value
      IO.puts String.duplicate("-", 50)
      IO.puts "BEGIN ADD BOOK PROCESS:"
      IO.puts String.duplicate("-", 50)
      if status != :available and status != :checked_out do
        IO.puts "Status must be :available"
        library
      else
        book = %Library{title: title, author: author, status: :available}
        IO.puts "Adding '#{title}' by '#{author}' to the library..."
        IO.puts String.duplicate("-", 50)
        IO.puts "ADD BOOK PROCESS COMPLETE"
        IO.puts String.duplicate("-", 50)
        library ++ [book]
      end
  end

  @doc "Changes the status of the book with the specified title to :checked_out if it’s available. If the book is already checked out, display a message indicating that. Returns the updated library."
  def checkout_book(library, title) do
      IO.puts String.duplicate("-", 50)
      IO.puts "BEGIN CHECKOUT PROCESS:"
      IO.puts String.duplicate("-", 50)
      # first, find the title
      IO.inspect(library, label: "library")
      IO.puts "Searching for '#{title}'..."
      checkout_book_index = Enum.find_index(library, fn book -> book.title == title end) # use a .key for structs and [:key] for maps!
      IO.puts "checkout_book_index: #{checkout_book_index}"
      checkout_book = Enum.at(library, checkout_book_index)
      IO.inspect(checkout_book, label: "checkout_book")
      # then, check if it's available
      if checkout_book.status == :available do
          # if it is, change the status to :checked_out
          checkout_book = %Library{checkout_book | status: :checked_out}
          IO.inspect(checkout_book, title: "updated checkout book:")
          IO.puts "'#{title}' has been checked out..."
          IO.puts String.duplicate("-", 50)
          IO.puts "CHECKOUT PROCESS COMPLETE"
          IO.puts String.duplicate("-", 50)
          List.replace_at(library, checkout_book_index, checkout_book)
      else
          # if it's not, display a message
          IO.puts "'#{title}' is already been checked out..."
          IO.puts String.duplicate("-", 50)
          IO.puts "CHECKOUT PROCESS COMPLETE"
          IO.puts String.duplicate("-", 50)
          library
      end
  end

  @doc "Changes the status of the book with the specified title back to :available if it’s currently checked out. If the book is already available, display a message indicating that. Returns the updated library."
  def return_book(library, title) do
      # find the book
      book_to_return_index = Enum.find_index(library, fn book -> book.title == title end)
      IO.inspect(book_to_return_index, label: "Index of the book to return")
      book_to_return = Enum.at(library, book_to_return_index)
      IO.inspect(book_to_return, label: "Book to return")
      # make sure its check out
      if book_to_return.status == :checked_out do
        # update it to available
        book_to_return = %Library{book_to_return | status: :available}
        IO.inspect(book_to_return, label: "Updated status of book to return")
        IO.puts "Random string"
      end
  end

  @doc "Prints all the books in the library along with their status (:available or :checked_out)."
  def list_books(library) do
      IO.puts "Listing all books in the library..."
      Enum.each(library, fn book -> IO.inspect(book) end)
  end

  @doc "Prints all books that are currently available for checkout."
  def list_available_books(library) do
    IO.puts "Listing all available books..."
    available_books = Enum.filter(library, fn book -> book.status == :available end)
    Library.list_books(available_books)
  end
end

# represent the library as a list of books
library = []
library = Library.add_book(library, "The Great Gatsby", "F. Scott Fitzgerald")
library = Library.add_book(library, "1984", "George Orwell")
library = Library.add_book(library, "Pride and Prejudice", "Jane Austen", :checked_out)
library = Library.add_book(library, "Moby Dick", "Herman Melville", :available)
library = Library.add_book(library, "War and Peace", "Leo Tolstoy", :available)
library = Library.checkout_book(library, "The Great Gatsby")   # Marks as checked_out
Library.list_books(library)
Library.list_available_books(library)                         # Shows only "1984"
Library.return_book(library, "The Great Gatsby")    # Marks as available again