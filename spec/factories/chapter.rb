FactoryBot.define do
  factory :chapter do
    title { Faker::Book.title }
    subtitle { rand() <= 0.75 ? Faker::Book.title : nil }
    book { create(:book) }
  end
end
