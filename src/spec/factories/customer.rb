FactoryBot.define do
  factory :customer do
    sequence(:email) { |n| "member#{n}@example.com" }
    name {"山田太郎"}
    nickname {"yamada"}
    password { "pw" }
    suspended { false }
    introduction {"こんにちは！"}
  end
end