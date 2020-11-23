module Steps
  class PublishNotifications
    include Interactor

    delegate :shipments, :statuses, to: :context

    def call
      context.published = shipments.each_with_object([]) do |shipment, array|
        array.push(shipment) if statuses[shipment.id] && publish_notification(shipment)
      end
    end

    private

    def publish_notification(shipment)
      Rails.logger.info("Publishing shipment '#{shipment.tracking_reference}'")
      begin
        SnsService.instance.publish(shipment)
        shipment.notification_status_published!
      rescue SnsServiceError => e
        context.fail!(error: e.message)
      end
    end
  end
end
