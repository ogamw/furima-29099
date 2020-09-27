require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nameとemail、password、password_confirmation、familyname、firstname、kana_familyname、kana_firstname、birthdayが存在すれば登録できること" do
        expect(@user).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it "nameが空では登録できないこと" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end

      it "emailが空では登録できないこと" do
        @usersemail = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "passwordが空では登録できないこと" do
        @user.encrypted_password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it"familynameが空では登録できないこと"do
        @user.familyname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Familyname can't be blank")
      end

      it"firstnameが空では登録できないこと"do
        @user.firstname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname can't be blank")
      end

      it"kana_familynameが空では登録できないこと"do
        @user.kana_familyname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana_familyname can't be blank")
      end

      it"kana_firstnamenameが空では登録できないこと"do
        @user.kana_firstname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana_firstname can't be blank")
      end

      it"birthdayが空では登録できないこと"do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
end