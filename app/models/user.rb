class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates :nickname, :birthday, presence: true
  validates :familyname, :firstname, presence: true,
                                     # 全角ひらがなカタカナ漢字のみ可
                                     format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'is must NOT contain any other characters than full-width characters (kanji, hiragana, katakana).' }
  validates :kana_familyname, :kana_firstname, presence: true,
                                               # 全角カナのみ可
                                               format: { with: /\A([ァ-ン]|ー)+\z/, message: 'is must NOT contain any other characters than full-width characters (katakana).' }

  validates :email, presence: true,
                    # @が含まれていれば可
                    format: { with: VALID_EMAIL_REGEX, message: 'is improper format.' }

  validates :password, presence: true,
                       # 半角英数字混合のみ可
                       format: { with: VALID_PASSWORD_REGEX, message: 'is must contain both letters and numbers.'}
end
