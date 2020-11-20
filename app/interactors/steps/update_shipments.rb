module Steps
  class UpdateShipments
    include Interactor

    delegate :shipments, :statuses, to: :context

    def call
      shipments.each do |shipment|
        update_shipment(shipment, statuses[shipment.id])
      end
    end

    private

    def update_shipment(shipment, tracking_status)
      shipment.update(tracking_status: tracking_status)
    end
  end
end
