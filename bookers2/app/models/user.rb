class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  # ここからフォロー・フォロワー機能のアソシエーション
  has_many :reverse_of_relationships, class_name:"Relationship",foreign_key:"followed_id", dependent: :destroy
  
  has_many :followers, through: :reverse_of_relationships, source: :follower
   # 被フォロー関係を通じて参照→followed_idをフォローしている人
  
  has_many :relationships, class_name:"Relationship",foreign_key:"follower_id", dependent: :destroy
   # 【class_name:"Relationship"】は省略可能
   
  has_many :followings, through: :relationships, source: :followed
   # 与フォロー関係を通じて参照→follower_idをフォローしている人
   
  # フォロー・フォロワーアソシエーション終了
  # ここからフォロー・フォロワー機能メソッド
  def follow(user_id)
    relationships.create(followed_id: user_id)
    
  end 
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
    
  end 
  
  def following?(user)
    followings.include?(user)
    
  end 
  # フォロー・フォロワー機能メソッド終了
  
  attachment :profile_image

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }


end
