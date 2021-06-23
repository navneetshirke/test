class FriendList < ApplicationRecord
  validates_uniqueness_of :sender_id, scope:  [:receiver_id]

  def self.users(id,status)
    ids = FriendList.where(status: status).where('sender_id = ? OR receiver_id = ?', id ,id).pluck(:sender_id,:receiver_id).compact.uniq.flatten
    return User.where(id: ids)
  end

  def self.check_status(current_user_id, user_id)
   FriendList.where(sender_id: user_id, receiver_id: current_user_id, status: false).present?
  end
end
