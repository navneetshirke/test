class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_one_attached :profile_pic, dependent: :destroy

  def friend_lists
    FriendList.where('sender_id = ? OR receiver_id = ?', self.id ,self.id )
  end

  def self.my_friend(user_1, user_2)
    FriendList.where('sender_id = ? AND receiver_id = ?',user_1, user_2).present?
  end

end
