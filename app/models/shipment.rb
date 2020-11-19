class Shipment < ApplicationRecord
  CARRIERS = %w[sandbox fedex]

  enum tracking_status: {
    created: 'created',
    on_transit: 'on_transit',
    delivered: 'delivered',
    exception: 'exception'
  }, _prefix: :tracking_status

  enum notification_status: {
    pending: 'pending',
    published: 'published'
  }, _prefix: :notification_status

  validates :carrier, :tracking_reference, presence: true
  validates :carrier, inclusion: { in: CARRIERS }, unless: -> { carrier.blank? }
end
