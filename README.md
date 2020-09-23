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

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| item_name       | string     | null: false                    |
| text            | text       | null: false                    |
| price           | string     | null: false                    |
| category_id     | integer    | null: false                    |
| condition_id    | integer    | null: false                    |
| postage_id      | integer    | null: false                    |
| days_to_ship_id | integer    | null: false                    |
| user_id         | references | null: false, foreign_key: true |

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
| postal_code     | string     | null: false                    |
| prefectures_id  | integer    | null: false                    |
| municipality    | string     | null: false                    |
| adress          | string     | null: false                    |
| building_name   | string     |                                |
| phone           | string     | null: false                    |
| purchase_id     | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase