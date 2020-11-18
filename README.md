## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|

### Association
- has_many :to_do_lists
- has_many :user_evaluations
- has_many :sell_items
- has_many :buy_items
- has_one :credit_card
- has_one :profile
- has_many :bookmarks

## profilesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birth_date|integer|null: false|
|user_id|reference|null: false, foreign_key: true|

### Association
- belongs_to:user

## Sending_destinationテーブル
|Column|Type|Options|
|------|----|-------|
|destination_first_name|string|null: false|
|destination_last_name|string|null: false|
|destination_first_name_kana|string|null: false|
|destination_last_name_kana|string|null: false|
|post_code|integer(7)|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string||
|phone_number|integer|unique: true|
|user_id|reference|null: false, foreign_key: true|

### Association
- belongs_to:user

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|customer_token|string|null: false|

### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|price|integer|null: false|
|category_id|reference|null:false,foreign_key: true|
|size|reference|null:false,foreign_key: true|
|brand_name|reference|null:false,foreign_key: true|
|condition_id|reference|null:false,foreign_key: true|
|postage_payer_id|reference|null:false,foreign_key: true|
|prefecture_id|integer|null: false|
|postage_type_id|integer|null: false|
|preparation_day_id|reference|null:false,foreign_key: true|
|user_id|reference|null:false,foreign_key: true|
|buyer_id|reference|foreign_key: true|

### Association
- has_many :item_images
- has_one :user_evaluation
- belongs_to :category
- belongs_to :size
- belongs_to :brand
- belongs_to :item_condition
- belongs_to :postage_payer
- belongs_to :preparation_day
- belongs_to :postage_type
- belongs_to :seller
- belongs_to :buyer
- Gem :jp_prefecture
- has_many :bookmarks

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|reference|null: false, foreign_key: true|
|image_url|string|null: false|

### Association
- belongs_to :items

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text||
|item_id|reference|null: false, foreign_key: true|
|user_id|reference|null: false, foreign_key: true|

### Association
- belongs_to :items
- belongs_to :user

## bookmarksテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|reference|null: false, foreign_key: true|
|user_id|reference|null: false, foreign_key: true|

### Association
- belongs_to :items
- belongs_to :user

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|

### Association
- has_many :items
- has_ancestry
