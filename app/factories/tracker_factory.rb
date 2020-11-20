class TrackerFactory
  TRACKERS = {
    sandbox: Trackers::SandboxTracker,
    fedex: Trackers::FedexTracker
  }

  def self.for(carrier, shipment)
    tracker_class = TRACKERS[carrier.to_sym]
    return unless tracker_class

    tracker_class.new(shipment)
  end
end
