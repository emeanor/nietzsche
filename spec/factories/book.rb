FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    subtitle { rand() <= 0.75 ? Faker::Book.title : nil }
    edition { create(:edition) }
  end
end