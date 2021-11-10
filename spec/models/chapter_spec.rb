require 'rails_helper'

RSpec.describe Chapter, type: :model do
  
  it { should belong_to(:book) }
  it { should have_many(:texts).through(:chapter_texts) }
  it { should validate_presence_of(:title) }

  let(:chapter) { create(:chapter) }

  it 'should have a valid factory' do
    expect(chapter).to be_valid
  end


  describe 'add_text' do

    context 'when text is not already in the chapter' do
      let(:text) { create(:text) }

      it 'should add the text to the chapter' do
        expect { chapter.add_text(text) }.to change { chapter.texts.count }.by(1)
      end

      context 'when a position argument is passed' do
        let!(:text1) { chapter.add_text(create(:text)) }
        let!(:text2) { chapter.add_text(create(:text)) }
        let!(:text3) { chapter.add_text(create(:text)) }
        let!(:valid_position) { chapter.add_text(create(:text), position=2) }
        let!(:invalid_position_high) { chapter.add_text(create(:text), position=20) }
        let!(:invalid_position_low) { chapter.add_text(create(:text), position=-5) }

        context 'when position is valid' do
          it 'should add the text at the correct position' do
            expect(chapter.chapter_texts.where(text: valid_position).first.position).to be(2)
          end
        end

        context 'when position is invalid' do
          it 'should add the text at the end of the chapter' do
            expect(chapter.chapter_texts.where(text: invalid_position_high).first.position).to be(5)
            expect(chapter.chapter_texts.where(text: invalid_position_low).first.position).to be(6)
          end
        end

      end

      context 'when no position argument is passed' do
        let!(:text) { chapter.add_text(create(:text)) }

        it 'should add the text at the end of the chapter' do
          expect(chapter.chapter_texts.maximum('position')).to eq (chapter.chapter_texts.where(text: text).first.position)
        end
      end

    end

    context 'when text is already in the chapter' do
      let!(:text) { chapter.add_text(create(:text)) }

      it 'should not add the text to the chapter' do
        expect { chapter.add_text(text) }.not_to change { chapter.texts.count }
      end
    end
  end


  describe 'remove_text' do
    let!(:text) { chapter.add_text(create(:text)) }

    it 'should remove the text from the chapter' do
      expect { chapter.remove_text(text) }.to change { chapter.texts.count }.by(-1)
    end
  end


  describe 'move_text' do
    let!(:text1) { chapter.add_text(create(:text)) }
    let!(:text2) { chapter.add_text(create(:text)) }
    let!(:text3) { chapter.add_text(create(:text)) }

    before do
      chapter.move_text(text1, position=3)
    end

    it 'should change the position of the text within the chapter' do
      expect(chapter.chapter_texts.where(text: text1).first.position).to be(3)
      expect(chapter.chapter_texts.where(text: text2).first.position).to be(1)
      expect(chapter.chapter_texts.where(text: text3).first.position).to be(2)
    end
  end

end
