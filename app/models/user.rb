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
  # 仮想的にUserモデルを２つに分ける(active_relationshipsとpassive_relatoinships)
  has_many :active_relationships, class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy
  # フォロワーを返す
  has_many :passive_relationships, class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
  # フォローしているユーザーを返す
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

# 既にfollowしていた場合、true
def following?(other_user)
  active_relationships.find_by(followed_id: other_user.id)
end
# follow(create)
def follow!(other_user)
  active_relationships.create!(followed_id: other_user.id)
end
# unfollow(destroy)
def unfollow!(other_user)
  active_relationships.find_by(followed_id: other_user.id).destroy
end

  attachment :profile_image, destroy: false

end
