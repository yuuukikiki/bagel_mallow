FactoryBot.define do
  factory :cart_item do
    quantity { 3 }

    association :cart # cartとの関連付け
    association :item # itemとの関連付け
  end
end
