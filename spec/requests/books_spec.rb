require 'rails_helper'

RSpec.describe "Books", type: :request do
  let(:expected_book_structure) do
    {
      "id"=> Integer,
      "title"=> String,
      "author"=> String,
      "read"=> [TrueClass, FalseClass],
    }
  end


  describe "GET /index" do
    before do
      create_list(:book, 3)
      get "/books"
      @body = JSON.parse(response.body)
    end

    it "returns books" do
      @body.each do |book|
        expect(book.keys).to contain_exactly(*expected_book_structure.keys)
      end
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "does not return empty if books exits" do
      expect(@body).not_to be_empty
    end

    it "returns 3 books" do
      expect(@body.size).to eq(3)
    end
  end

describe "GET /show" do
  let(:book_id) { create(:book).id }

  before do
    get "/books/#{book_id}"
    @body = JSON.parse(response.body)
  end

  it "checks for the correct structure" do
    expect(@body.keys).to contain_exactly(*expected_book_structure.keys)
  end

  it "returns http success" do
    expect(response).to have_http_status(:success)
  end


describe "POST /create" do  
  post "/books", params: atrributes_for(:book)
  @body = JSON.parse(response.body)
end

it "checks for the correct structure" do
  expect(@body.keys).to contain_exactly(*expected_book_structure.keys)
end

it "count of books increases by 1" do
  expect(Book.count).to eq(1)
end

it "returns http success" do
  expect(response).to have_http_status(:success)
end
end 

describe "PUT /update" do
  let(:book_id) { create(:book).id }  

  before do 
    put "/books/#{book_id}", params: { book: { title: "Updated Title" } }
  end

  it "checks for the correct structure" do
    @body = JSON.parse(response.body)
    expect(@body.keys).to contain_exactly(*expected_book_structure.keys)
  end

  it "checks if the body is updated" do
    expect(book.find(book_id).title).to eq("Updated Title")
  end

  it "returns http success" do
    expect(response).to have_http_status(:success)
  end
end

describe "DELETE /destroy" do
  let(:book_id) { create(:book).id }

  before do
    delete "/books/#{book_id}"
  end

 it "decreases the count of books by 1" do
    expect(Book.count).to eq(0)
  end

  it "deletes the book" do
    expect(Book.exists?(book_id)).to be_falsey
  end

  it "returns a success message" do
    expect(JSON.parse(response.body)["message"]).to eq("Book deleted successfully")
  end
end
end 

