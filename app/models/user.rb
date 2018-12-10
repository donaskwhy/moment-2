class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :user_alarms, dependent: :destroy

  def is_friend(other_user) #친구인지 확인
    result = false
    tmp_friend1 = Friend.where(user1: self)
    tmp_friend2 = Friend.where(user2: self)
    if tmp_friend1.present?
      if tmp_friend1.pluck('user2_id').include?(other_user.id)
        result = true
      end
    end
    if tmp_friend2.present?
      if tmp_friend2.pluck('user1_id').include?(other_user.id)
        result = true
      end
    end
    return result
  end

  def sent_friend(other_user) #A가 B에게 친구요청을 보낸 상태인지 확인
    result = false
    friendrequest = UserAlarm.where(send_user: self)
    if friendrequest.present?
      if friendrequest.pluck('user_id').include?(other_user.id)
        result = true
      end
    end
    return result
  end

  def received_friend(other_user) #A가 B로부터 친구요청을 받은 상태인지 확인
    result = false
    friendrequest = UserAlarm.find_by(user_id: self.id, send_user_id: other_user.id)
    if friendrequest.present?
      result = true
    end
  end

  def friend_users #친구 정보 불러오기
    tmp_friend1 = Friend.where(user1: self )
    tmp1_ids = tmp_friend1.pluck(:user2_id)
    tmp_friend2 = Friend.where(user2: self)
    tmp2_ids = tmp_friend2.pluck(:user1_id)
    friends = tmp1_ids + tmp2_ids
    User.where(id: friends)
  end

end
