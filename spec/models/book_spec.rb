require 'rails_helper'

RSpec.describe Book, type: :model do
  
  it { should belong_to(:edition) }
  it { should have_many(:chapters) }
  it { should validate_presence_of(:title) }

  let(:book) { create(:book) }

  it 'should have a valid factory' do
    expect(book).to be_valid
  end


  describe 'create_chapter' do

    it 'should add the chapter to the book' do
      expect { book.add_chapter(create(:chapter)) }.to change { book.chapters.count }.by(1)
    end

    context 'when a position argument is passed' do
      let!(:chapter1) { book.add_chapter(create(:chapter)) }
      let!(:chapter2) { book.add_chapter(create(:chapter)) }
      let!(:chapter3) { book.add_chapter(create(:chapter)) }
      let!(:valid_position) { book.add_chapter(create(:chapter), position = 2) }
      let!(:invalid_position_high) { book.add_chapter(create(:chapter), position = 20) }
      let!(:invalid_position_low) { book.add_chapter(create(:chapter), position = -2) }

      context 'when position is valid' do
        it 'should add the chapter at the correct position' do
          expect(valid_position.position).to be(2) 
        end
      end

      context 'when position is invalid' do
        it 'should add the chapter at the end of the book' do
          expect(invalid_position_high.position).to be(5)
          expect(invalid_position_low.position).to be(6)
        end
      end

    end

    context 'when no position argument is passed' do
      let!(:chapter) { book.add_chapter(create(:chapter)) }

      it 'should add the chapter at the end of the book' do
        expect(book.chapters.maximum('position')).to eq (book.chapters.where(id: chapter.id).first.position)
      end
    end

  end


  describe 'destroy_chapter' do
    let!(:chapter) { book.add_chapter(create(:chapter)) }

    it 'should remove the chapter from the book' do
      expect { book.destroy_chapter(chapter) }.to change { book.chapters.count }.by(-1)
    end
  end


  describe 'move_chapter' do
    let!(:chapter1) { book.add_chapter(create(:chapter)) }
    let!(:chapter2) { book.add_chapter(create(:chapter)) }
    let!(:chapter3) { book.add_chapter(create(:chapter)) }

    before do
      book.move_chapter(chapter1, position = 3)
    end

    it 'should change the position of the chapter within the book' do
      expect(chapter1.reload.position).to be(3)
      expect(chapter2.reload.position).to be(1)
      expect(chapter3.reload.position).to be(2)
    end
  end

end