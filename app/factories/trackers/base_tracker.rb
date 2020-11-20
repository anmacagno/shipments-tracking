module Trackers
  class BaseTracker
    attr_accessor :shipment

    def initialize(shipment)
      @shipment = shipment
    end

    def track_status
      raise NotImplementedError
    end
  end
end
