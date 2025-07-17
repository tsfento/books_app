require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it { should validate_inclusion_of(:read).in_array([true, false]) }
  end

  describe 'invalid if no title' do
    it 'is invalid without a title' do
      book = FactoryBot.build(:book, title: nil)
      expect(book).not_to be_valid
      expect(book.errors[:title]).to include("can't be blank")
    end
  end

  describe 'invalid if no author' do
    it 'is invalid without an author' do
      book = FactoryBot.build(:book, author: nil)
      expect(book).not_to be_valid
      expect(book.errors[:author]).to include("can't be blank")
    end
  end

  describe 'invalaid if read is nil' do
    it 'is invalid if read is nil' do
      book = FactoryBot.build(:book, read: nil)
      expect(book).not_to be_valid
      expect(book.errors[:read]).to include("is not included in the list")
    end
  end

  describe 'default values' do
    it 'sets read to false by default' do
      book = FactoryBot.create(:book)
      expect(book.read).to be_falsey
    end
  end

  describe 'factory' do
    it 'creates a valid book' do
      book = FactoryBot.build(:book)
      expect(book).to be_valid
    end
  end
end
