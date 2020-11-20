module Steps
  class PublishNotifications
    include Interactor

    delegate :shipments, to: :context

    def call
      context.published = shipments.each_with_object([]) do |shipment, array|
        array.push(shipment) if publish_notification(shipment)
      end
    end

    private

    def publish_notification(shipment)
      shipment.notification_status_published!
    end
  end
end
