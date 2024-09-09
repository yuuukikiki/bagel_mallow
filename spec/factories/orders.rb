FactoryBot.define do
  factory :order do
    total_amount { 1000 }

    association :user # userとの関連付け
    association :address # addressとの関連付け
  end
end
