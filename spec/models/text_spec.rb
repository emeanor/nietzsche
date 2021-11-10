require 'rails_helper'

RSpec.describe Text, type: :model do

  it { should validate_presence_of(:nietzsche_number) }
  it { should validate_presence_of(:kgw_notebook_number) }
  it { should validate_presence_of(:kgw_text_number) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:url_slug) }
  it { should have_many(:chapters).through(:chapter_texts) }

  describe 'uniqueness constraints' do
    subject { build(:text) }
    it { should validate_uniqueness_of(:url_slug).case_insensitive }
  end

  let(:text) { create(:text) }
  
  it 'should have a valid factory' do
    expect(text).to be_valid
  end

end
