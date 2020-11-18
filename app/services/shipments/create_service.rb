module Shipments
  class CreateService < ApplicationService
    attr_reader :carrier, :tracking_reference

    def initialize(params)
      @carrier = params[:carrier]
      @tracking_reference = params[:tracking_reference]
    end

    def call
      create_shipment
    end

    private

    def create_shipment
      shipment = Shipment.new(carrier: carrier, tracking_reference: tracking_reference)
      shipment.save
    end
  end
end
