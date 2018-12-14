class NotificationsController < ApplicationController
  after_action :index_read, only: [:index]

  def index
    @notifications = current_user.notifications
 end

  def index_read
    for @notification in @notifications do
     @notification.destroy
    end
  end

end
