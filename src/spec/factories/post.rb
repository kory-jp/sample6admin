FactoryBot.define do
  factory :post do
    sequence(:title) {|n| "テスト投稿#{n}"}
    sequence(:body) { |n| "テスト投稿#{n}です。"}
  end
end