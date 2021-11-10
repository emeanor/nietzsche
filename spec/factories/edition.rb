FactoryBot.define do
  factory :edition do
    title { Faker::Book.title }
    subtitle { rand() <= 0.75 ? Faker::Book.title : nil }
    user { create(:user) }
  end
end