class Shipment < ApplicationRecord
  CARRIERS = %w[sandbox fedex]

  enum tracking_status: [:created, :on_transit, :delivered, :exception], _prefix: :tracking_status
  enum notification_status: [:pending, :published], _prefix: :notification_status

  validates :carrier, :tracking_reference, presence: true
  validates :carrier, inclusion: { in: CARRIERS }, unless: -> { carrier.blank? }
end
