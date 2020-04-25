class Relationship < ApplicationRecord

	belongs_to :follower, class_name: "User"
	belongs_to :following, class_name: "User"
	# Userモデルに対してfollower_idでbelongs_toの関連付け

	validates :follower_id, presence: true
    validates :following_id, presence: true

end
