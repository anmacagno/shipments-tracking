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

    def track_shipment(shipment)
      'delivered'
    end
  end
end
