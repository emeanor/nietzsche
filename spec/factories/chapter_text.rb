FactoryBot.define do
  factory :chapter_text do
    chapter { create(:chapter) }
    text { create(:text) }
  end
end