class NotificationsController < ApplicationController
  after_action :index_read, only: [:index]

  def index
    @notifications = current_user.notifications
 end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to user_path @notification.user
  end

  def index_read
    for @notification in @notifications do
     @notification.destroy
    end
  end

end
