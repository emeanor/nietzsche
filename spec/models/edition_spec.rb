require 'rails_helper'

RSpec.describe Edition, type: :model do
  
  it { should validate_presence_of(:title) }
  it { should have_many(:books) }

  let(:edition) { create(:edition) }

  it 'should have a valid factory' do
    expect(edition).to be_valid
  end


  describe 'add_book' do
    let(:book) { create(:book) }

    it 'should add the book to the edition' do
      expect { edition.add_book(book) }.to change { edition.books.count }.by(1)
    end

    context 'when a position argument is passed' do
      let!(:book1) { edition.add_book(create(:book)) }
      let!(:book2) { edition.add_book(create(:book)) }
      let!(:book3) { edition.add_book(create(:book)) }
      let!(:valid_position) { edition.add_book(create(:book, title: 'Valid Position'), 2) }
      let!(:invalid_position_high) { edition.add_book(create(:book, title: 'Invalid Position High'), 20) }
      let!(:invalid_position_low) { edition.add_book(create(:book, title: 'Invalid Position Low'), -2) }

      context 'when position is valid' do
        it 'should create the book at the correct position' do
          expect(valid_position.position).to be(2) 
        end
      end

      context 'when position is invalid' do
        it 'should create the book at the end of the edition' do
          expect(invalid_position_high.position).to be(5)
          expect(invalid_position_low.position).to be(6)
        end
      end

    end

    context 'when no position argument is passed' do
      let!(:book) { edition.add_book(create(:book)) }

      it 'should add the book at the end of the edition' do
        expect(edition.books.maximum('position')).to eq (edition.books.where(id: book.id).first.position)
      end
    end

  end


  describe 'destroy_book' do
    let!(:book) { edition.add_book(create(:book)) }

    it 'should remove the book from the edition' do
      expect { edition.destroy_book(book) }.to change { edition.books.count }.by(-1)
    end
  end


  describe 'move_book' do
    let!(:book1) { edition.add_book(create(:book)) }
    let!(:book2) { edition.add_book(create(:book)) }
    let!(:book3) { edition.add_book(create(:book)) }

    before do
      edition.move_book(book1, position=3)
    end

    it 'should change the position of the book within the edition' do
      expect(book1.reload.position).to be(3)
      expect(book2.reload.position).to be(1)
      expect(book3.reload.position).to be(2)
    end
  end

end