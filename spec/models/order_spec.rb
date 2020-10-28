require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe '#create' do
    before do
      @order = FactoryBot.build(:transaction)
    end
    describe '商品購入機能' do
      context '商品の購入がうまくいくとき' do
        it 'tokenとpostal_codeとprefecture_idとmunicipalityとaddressとphoneが存在すれば登録できる' do
          expect(@order).to be_valid
        end

        it 'building_nameが存在しなくても登録できる' do
          @order.building_name = nil
          expect(@order).to be_valid
        end
      end

      context '商品の購入がうまくいかないとき' do
        it 'tokenが空では登録できない' do
          @order.token = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Token can't be blank")
        end

        it 'postal_codeが空では登録できない' do
          @order.postal_code = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Postal code can't be blank")
        end

        it 'postal_codeがハイフンがなければ登録できない' do
          @order.postal_code = '1234567'
          @order.valid?
          expect(@order.errors.full_messages).to include('Postal code is invalid')
        end

        it 'prefecture_idが空では登録できない' do
          @order.prefecture_id = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Prefecture  can't be blank")
        end

        it 'prefecture_idが1では登録できない' do
          @order.prefecture_id = 1
          @order.valid?
          expect(@order.errors.full_messages).to include('Prefecture Select')
        end

        it 'municipalityが空では登録できない' do
          @order.municipality = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Municipality can't be blank")
        end

        it 'addressが空では登録できない' do
          @order.address = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Address can't be blank")
        end

        it 'phoneが空では登録できない' do
          @order.phone = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Phone can't be blank")
        end

        it 'phoneがハイフンは不要で、11桁以内でないと登録できない' do
          @order.phone = '123-45678901'
          @order.valid?
          expect(@order.errors.full_messages).to include('Phone は「-」を入力しないでください')
        end
      end
    end
  end
end

# it 'userが紐付いていないと保存できないこと' do
#   @order.user = nil
#   @order.valid?
#   expect(@order.errors.full_messages).to include('User must exist')
# end
