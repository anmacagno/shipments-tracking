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
      if shipment.save
        OpenStruct.new(success?: true, shipment: shipment, errors: nil)
      else
        OpenStruct.new(success?: false, shipment: nil, errors: shipment.errors.full_messages)
      end
    end
  end
end
