class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname,  :birthday, presence: true
  validates :familyname, :firstname, presence: true
            #全角ひらがなカタカナ漢字
            format: { with:/^[ぁ-んァ-ン一-龥]/, message: "is must NOT contain any other characters than alphanumerics." }
  validates :kana_familiyname, :kana_firstnamename, presence: true
            #全角カタカナ
            format: { with:/^([ァ-ン]|ー)+$/, message: "is must NOT contain any other characters than alphanumerics." }
end
