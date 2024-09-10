FactoryBot.define do
  factory :order_item do
    quantity { 1 }

    association :order # orderとの関連付け
    association :item # itemとの関連付け
  end
end
