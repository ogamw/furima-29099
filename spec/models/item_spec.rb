require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @items = FactoryBot.build(:item)
    end

    describe '商品出品機能' do
      context '商品の出品がうまくいくとき' do
        it 'imageとitem_name、text、category_id、condition_id、postage_id、shipping_area_id,days_to_ship_id、priceが存在すれば登録できる' do
          expect(@items).to be_valid
        end
      end

      context '商品の出品がうまくいかないとき' do
        it 'imageが空では登録できない' do
          @items.image = nil
          @items.valid?
          expect(@items.errors.full_messages).to include("Image can't be blank")
        end
        it 'item_nameが空では登録できない' do
          @items.item_name = nil
          @items.valid?
          expect(@items.errors.full_messages).to include("Item name can't be blank")
        end

        it 'textが空では登録できない' do
          @items.text = nil
          @items.valid?
          expect(@items.errors.full_messages).to include("Text can't be blank")
        end

        it 'category_idが1では登録できない' do
          @items.category_id = '1'
          @items.valid?
          expect(@items.errors.full_messages).to include("Category Select")
        end

        it 'condition_idが1では登録できない' do
          @items.condition_id = '1'
          @items.valid?
          expect(@items.errors.full_messages).to include("Condition Select")
        end

        it 'postage_idが1では登録できない' do
          @items.postage_id = '1'
          @items.valid?
          expect(@items.errors.full_messages).to include("Postage Select")
        end


        it 'shipping_area_idが1では登録できない' do
          @items.shipping_area_id = '1'
          @items.valid?
          expect(@items.errors.full_messages).to include("Shipping area Select")
        end

        it 'days_to_ship_idが1では登録できない' do
          @items.days_to_ship_id = '1'
          @items.valid?
          expect(@items.errors.full_messages).to include("Days to ship Select")
        end

        it 'priceが空では登録できない' do
          @items.price = nil
          @items.valid?
          expect(@items.errors.full_messages).to include("Price can't be blank")
        end

        it 'priceが半角数字以外があれば登録できない' do
          @items.price = nil
          @items.valid?
          expect(@items.errors.full_messages).to include('Price out of setting range.')
        end

        it 'userが紐付いていないと保存できないこと' do
          @items.user = nil
          @items.valid?
          expect(@items.errors.full_messages).to include("User must exist")
        end
      end
    end
  end
end
