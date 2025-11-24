class NotificationService
  def initialize
    @fcm = FCM.new(ENV.fetch('FCM_SERVER_KEY', 'placeholder_key'))
  end

  def store_updated(store)
    title = "New Store Update"
    body = "#{store.space_name || store.name} is now updated!"
    data = { type: 'store', id: store.id }
    send_notification(title, body, data)
  end

  def menu_item_updated(item)
    title = "New Menu Item"
    body = "#{item.name} is now available at #{item.category&.store&.name}!"
    data = { type: 'menu_item', id: item.id }
    send_notification(title, body, data)
  end

  def send_custom_notification(title, body, data = {})
    send_notification(title, body, data)
  end

  private

  def send_notification(title, body, data)
    options = {
      notification: {
        title: title,
        body: body
      },
      data: data,
      priority: 'high',
      to: '/topics/all'
    }
    
    begin
      response = @fcm.send(options[:to], options)
      Rails.logger.info "FCM Response: #{response}"
    rescue => e
      Rails.logger.error "FCM Error: #{e.message}"
    end
  end
end
