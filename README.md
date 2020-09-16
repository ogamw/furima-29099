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
| kana_familiyname | string | null: false |
| kana_firstname   | string | null: false |
| birthday         | date   | null: false |

### Association

- has_many :items
- has_many :purchases
- has_many :addresses

## items テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| item_name    | string     | null: false                    |
| text         | string     | null: false                    |
| category     | string     | null: false                    |
| condition    | string     | null: false                    |
| postage      | string     | null: false                    |
| days_to_ship | string     | null: false                    |
| user_id      | references | null: false, foreign_key: true |

### Association

- has_one :purchase
- belongs_to :user

## purchase テーブル

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
| familyname      | string     | null: false                    |
| firstname       | string     | null: false                    |
| kana_familyname | string     | null: false                    |
| kana_firstname  | string     | null: false                    |
| postal_code     | string     | null: false                    |
| prefectures     | string     | null: false                    |
| municipality    | string     | null: false                    |
| adress          | string     | null: false                    |
| building_name   | string     | null: false                    |
| phone           | string     | null: false                    |
| purchase_id     | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase