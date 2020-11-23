module Trackers
  class FedexTracker < BaseTracker
    def track_status
      tracking_information = FedexService.instance.track(shipment.tracking_reference)
      tracking_information.status
    end
  end
end
