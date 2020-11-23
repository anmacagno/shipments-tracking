module Trackers
  class FedexTracker < BaseTracker
    ON_TRANSIT_STATUS_CODES = %w[IT HL CC OD DP SF FD AR PU AP]
    DELIVERED_STATUS_CODES = %w[DL]
    EXCEPTION_STATUS_CODES = %w[CA DE SE]

    def track_status
      tracking_information = FedexService.instance.track(shipment.tracking_reference)
      homologate_status_code(tracking_information.status_code)
    end

    private

    def homologate_status_code(status_code)
      if ON_TRANSIT_STATUS_CODES.include?(status_code)
        Shipment.tracking_statuses[:on_transit]
      elsif DELIVERED_STATUS_CODES.include?(status_code)
        Shipment.tracking_statuses[:delivered]
      elsif EXCEPTION_STATUS_CODES.include?(status_code)
        Shipment.tracking_statuses[:exception]
      else
        Shipment.tracking_statuses[:created]
      end
    end
  end
end
