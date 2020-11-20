module Steps
  class FindShipments
    include Interactor

    delegate :carrier, to: :context

    def call
      if Shipment::CARRIERS.include?(carrier)
        context.shipments = find_shipments
      else
        context.fail!(error: "The carrier must be one of the following: #{Shipment::CARRIERS}")
      end
    end

    private

    def find_shipments
      Shipment.where(carrier: carrier).notification_status_pending
    end
  end
end
