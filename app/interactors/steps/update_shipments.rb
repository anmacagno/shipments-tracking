module Steps
  class UpdateShipments
    include Interactor

    delegate :shipments, :statuses, to: :context

    def call
      shipments.each do |shipment|
        tracking_status = statuses[shipment.id]
        update_shipment(shipment, tracking_status) if tracking_status
      end
    end

    private

    def update_shipment(shipment, tracking_status)
      shipment.update(tracking_status: tracking_status)
    end
  end
end
