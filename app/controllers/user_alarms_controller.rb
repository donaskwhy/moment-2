class UserAlarmsController < ApplicationController
  before_action :set_post, only: [:delete_alarm, :allow_friend, :reject_friend]

  def show
    @user = User.find(params[:id])
    @user_alarms = @user.user_alarms
  end

  def delete_alarm
    @user_alarm.destroy
  end

  def allow_friend #친구 신청 수락
    @user1 = @user_alarm.user
    @user2 = @user_alarm.send_user
    if @user1.id > @user2.id ##중복생성 방지위해 항상 id값이 큰 것이 plyaer2_id에 저장되도록
      Friend.create(user1_id: @user2.id, user2_id: @user1.id)
    else
      Friend.create(user1_id: @user1.id, user2_id: @user2.id)
    end
    @user_alarm.destroy

    respond_to do |format|
      format.js
    end
  end

  def reject_friend #친구 신청 거절
    @user_alarm.destroy

    respond_to do |format|
      format.js
    end
  end

  private
  def find_user_alarm
    @user_alarm = UserAlarm.find(params[:id])
  end

end
