# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| familyname       | string | null: false |
| firstname        | string | null: false |
| kana_familyname  | string | null: false |
| kana_firstname   | string | null: false |
| birthday         | date   | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| item_name        | string     | null: false                    |
| text             | text       | null: false                    |
| price            | integer    | null: false                    |
| category_id      | integer    | null: false                    |
| condition_id     | integer    | null: false                    |
| postage_id       | integer    | null: false                    |
| shipping_area_id | integer    | null: false                    |
| days_to_ship_id  | integer    | null: false                    |
| user_id          | references | null: false, foreign_key: true |

### Association

- has_one :orders
- belongs_to :user
- has_many :tag_items
- has_many :tags, through: tag_items

## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- has_one :address
- belongs_to :user
- belongs_to :item

## address テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| municipality    | string     | null: false                    |
| address         | string     | null: false                    |
| building_name   | string     |                                |
| phone           | string     | null: false                    |
| order_id        | references | null: false, foreign_key: true |

### Association

- belongs_to :order

## tags テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| tag_name   | string | null: false |

### Association

- has_many :tag_items
- has_many :items, through: tag_items

## tag_items テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| tag    | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :tag
- belongs_to :item