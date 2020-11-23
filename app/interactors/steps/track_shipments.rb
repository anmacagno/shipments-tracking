module Steps
  class TrackShipments
    include Interactor

    delegate :carrier, :shipments, to: :context

    def call
      context.statuses = shipments.each_with_object({}) do |shipment, hash|
        hash[shipment.id] = track_shipment(shipment)
      end
      context.statuses.delete_if { |key, value| value.blank? }
    end

    private

    def track_shipment(shipment)
      Rails.logger.info("Tracking shipment '#{shipment.tracking_reference}'")
      begin
        tracker = TrackerFactory.for(carrier, shipment)
        tracker.track_status
      rescue FedexServiceError => e
        Rails.logger.info(e.message)
        nil
      end
    end
  end
end
