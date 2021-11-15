FactoryBot.define do
  factory :edition do
    title { Faker::Book.title }
    subtitle { rand() <= 0.75 ? Faker::Book.title : nil }
    user { create(:user) }
    editor_intro { Faker::Lorem.paragraph(sentence_count: 30, random_sentences_to_add: 5) }
  end
end