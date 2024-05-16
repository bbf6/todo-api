class Task < ApplicationRecord
  after_commit { broadcast_changes }

  private

  def broadcast_changes
    params = { action: 'changes' }
    ActionCable.server.broadcast 'tasks_notifications_channel', params
  end
end
