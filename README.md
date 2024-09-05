

## users テーブル

| Column                | Type   | Options      |
| --------------------- | ------ | ------------ |
| name                  | string | null: false  |
| phone_number          | string | null: false  |
| email                 | string | unique: true, null: false|

### Association

- has_many :addresses
- has_many :orders


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
- belongs_to :order
- belongs_to_active_hash :prefecture



## products テーブル

| Column           | Type       | Options     |
| -----------------| ---------- | ----------- |
| name             | string     | null: false |
| description      | text       | null: false |
| price            | integer    | null: false |
| image_url        | string     | null: false |

### Association

- has_many :order_items


## orders テーブル

| Column           | Type       | Options                         |
| ---------------- | ---------- | ------------------------------- |
| user             | references | null: false, foreign_key: true  |
| total_amount     | integer    | null: false                     |
| status           | string     | null: false                     |
|shipping_address  | references | null: false, foreign_key: true  |

### Association

- belongs_to :user
- has_one :address
- has_many :order_items


## order_items テーブル

| Column           | Type       | Options                         |
| ---------------- | ---------- | ------------------------------- |
| order            | references | null: false, foreign_key: true  |
| product          | references | null: false, foreign_key: true  |
| quantity         | integer    | null: false                     |
| price            | integer    | null: false                     |

### Association

- belongs_to :order
- belongs_to :product