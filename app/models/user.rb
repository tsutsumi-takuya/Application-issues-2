class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:validatable

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, uniqueness: true, length: {maximum: 20, minimum: 2}
  validates :introduction, uniqueness: true, length:{maximum: 50}

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # フォロワーを返す
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  # フォローしているユーザーを返す
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships


# 既にfollowしていた場合、true
def following?(other_user)
  following_relationships.find_by(following_id: other_user.id)
end
# follow(create)
def follow!(other_user)
  following_relationships.create!(following_id: other_user.id)
end
# unfollow(destroy)
def unfollow!(other_user)
  following_relationships.find_by(following_id: other_user.id).destroy
end

  attachment :profile_image, destroy: false

end
