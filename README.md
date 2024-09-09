

## users テーブル

| Column                | Type   | Options      |
| --------------------- | ------ | ------------ |
| name                  | string | null: false  |
| phone_number          | string | null: false  |
| email                 | string | unique: true, null: false|

### Association

- has_many :addresses
- has_many :orders
- has_one :cart


## addresses テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| postal_code   | string     | null: false |
| city          | string     | null: false |
| street        | string     | null: false |
| building_name | string     | null: true  |
| phone_number  | string     | null: false |
| user          | references | null: false, foreign_key: true|
| prefecture_id | integer    | null: false |

### Association

- belongs_to :user
- has_many :orders
- belongs_to_active_hash :prefecture



## items テーブル

| Column           | Type       | Options     |
| -----------------| ---------- | ----------- |
| name             | string     | null: false |
| description      | text       | null: false |
| price            | integer    | null: false |
| image_url        | string     | null: false |

### Association

- has_many :order_items
- has_many :cart_items


## orders テーブル

| Column           | Type       | Options                         |
| ---------------- | ---------- | ------------------------------- |
| user             | references | null: false, foreign_key: true  |
| total_amount     | integer    | null: false                     |
| status           | string     | null: false                     |
| shipping_address | references | null: false, foreign_key: true  |

### Association

- belongs_to :user
- belongs_to :address
- has_many :order_items


## order_items テーブル

| Column           | Type       | Options                         |
| ---------------- | ---------- | ------------------------------- |
| order            | references | null: false, foreign_key: true  |
| item             | references | null: false, foreign_key: true  |
| quantity         | integer    | null: false                     |
| price            | integer    | null: false                     |

### Association

- belongs_to :order
- belongs_to :item


## carts テーブル

| Column      | Type       | Options                         |
| ----------- | ---------- | --------------------------------|
| user        | references | null: false, foreign_key: true   |

### Association

- belongs_to :user
- has_many :cart_items, dependent: :destroy


## cart_items テーブル

| Column      | Type       | Options                         |
| ----------- | ---------- | --------------------------------|
| cart        | references | null: false, foreign_key: true  |
| item        | references | null: false, foreign_key: true  |
| quantity    | integer    | null: false                     |

### Association

- belongs_to :cart
- belongs_to :item


## contacts テーブル

| Column      | Type       | Options                         |
| ----------- | ---------- | --------------------------------|
| name        | string     | null: false                     |
| email       | string     | null: false                     |
| message     | text       | null: false                     |
