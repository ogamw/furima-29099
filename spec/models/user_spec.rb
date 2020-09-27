require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it 'nameとemail、password、password_confirmation、familyname、firstname、kana_familyname、kana_firstname、birthdayが存在すれば登録できる' do
          expect(@user).to be_valid
        end

        it 'emailが＠ありであれば登録できること' do
          @user.email = '0000@0000.com'
          expect(@user).to be_valid
        end

        it 'passwordが6文字以上あれば登録できる' do
          @user.password = '0123ab'
          @user.password_confirmation = '0123ab'
          expect(@user).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it 'nameが空では登録できない' do
          @user.nickname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'emailが空では登録できない' do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it '重複したemailが存在する場合登録できない' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end

        it 'emailに＠がなければ登録できない' do
          @user.email = '0000a0000.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is improper format.')
        end

        it 'passwordが空では登録できない' do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it 'passwordが5文字以下であれば登録できない' do
          @user.password = '012ab'
          @user.password_confirmation = '012ab'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end

        it 'passwordが英数字混合でなければ登録できない' do
          @user.password = '012345'
          @user.password_confirmation = '012345'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is must contain both letters and numbers.')
        end

        it 'passwordが存在してもpassword_confirmationが空では登録できない' do
          @user.password = '0123ab'
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'familynameが空では登録できない' do
          @user.familyname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Familyname can't be blank")
        end

        it 'familynameに全角（漢字・ひらがな・カタカナ）以外があれば登録できない' do
          @user.familyname = 'aaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include 'Familyname is must NOT contain any other characters than full-width characters (kanji, hiragana, katakana).'
        end

        it 'firstnameが空では登録できない' do
          @user.firstname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Firstname can't be blank")
        end

        it 'firstnameに全角（漢字・ひらがな・カタカナ）以外があれば登録できない' do
          @user.firstname = 'aaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include 'Firstname is must NOT contain any other characters than full-width characters (kanji, hiragana, katakana).'
        end

        it 'kana_familynameが空では登録できない' do
          @user.kana_familyname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Kana familyname can't be blank")
        end

        it 'kana_familynameに全角カタカナ以外があれば登録できない' do
          @user.kana_familyname = 'aaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include 'Kana familyname is must NOT contain any other characters than full-width characters (katakana).'
        end

        it 'kana_firstnamenameが空では登録できない' do
          @user.kana_firstname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Kana firstname can't be blank")
        end

        it 'kana_firstnameに全角カタカナ以外があれば登録できない' do
          @user.kana_firstname = 'aaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include 'Kana firstname is must NOT contain any other characters than full-width characters (katakana).'
        end

        it 'birthdayが空では登録できない' do
          @user.birthday = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end
      end
    end
  end
end
