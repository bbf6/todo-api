class TasksNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'tasks_notifications_channel'
  end

  def unsubscribed
  end
end
