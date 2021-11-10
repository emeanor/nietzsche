require 'rails_helper'

RSpec.describe ChapterText, type: :model do

  it { should belong_to(:chapter) }
  it { should belong_to(:text) }

  let(:chapter_text) { create(:chapter_text) }

  it 'should have a valid factory' do
    expect(chapter_text).to be_valid
  end

end