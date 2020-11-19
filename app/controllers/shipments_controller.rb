class ShipmentsController < ApplicationController
  def create
    result = Shipments::CreateService.call(shipment_params)
    if result.success?
      render json: result.shipment, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def shipment_params
    params.fetch(:shipment, {}).permit(:carrier, :tracking_reference)
  end
end
