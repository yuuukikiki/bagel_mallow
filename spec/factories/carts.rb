FactoryBot.define do
  factory :cart do
    association :user # userとの関連付け
  end
end
