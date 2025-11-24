module Api
  module V1
    module Admin
      class NotificationsController < ApplicationController
        # POST /api/v1/admin/notifications/send
        def send_notification
          title = params[:title]
          body = params[:body]
          data = params[:data] || {}

          service = NotificationService.new
          service.send_custom_notification(title, body, data)

          render json: { message: 'Notification sent successfully' }, status: :ok
        end
      end
    end
  end
end
