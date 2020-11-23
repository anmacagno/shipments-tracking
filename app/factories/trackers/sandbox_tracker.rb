module Trackers
  class SandboxTracker < BaseTracker
    def track_status
      Shipment.tracking_statuses[:delivered]
    end
  end
end
