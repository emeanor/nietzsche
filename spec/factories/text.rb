FactoryBot.define do
  factory :text do
    nietzsche_number { Faker::Number.within(range: 1..372) }
    kgw_notebook_number { Faker::Number.within(range: 9..11) }
    kgw_text_number { Faker::Number.within(range: 1..999) }
    book_number { rand() <= 0.75 ? (Faker::Number.within(range: 1..4)).to_s : nil }
    url_slug { nietzsche_number.to_s }
    title { Faker::Book.title }
    text { Faker::Lorem.paragraph(sentence_count: 10, random_sentences_to_add: 5) }
  end
end