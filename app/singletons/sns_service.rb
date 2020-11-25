class SnsService
  include Singleton

  PARAMS = {
    region: 'us-east-1',
    access_key_id: 'AKIAQVVTRAORVTBBE35J',
    secret_access_key: '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',
    topic: 'arn:aws:sns:us-east-1:046547403683:ShipmentNotificationCreated'
  }

  private_constant :PARAMS

  attr_accessor :topic

  def initialize
    client = Aws::SNS::Client.new(
      region: PARAMS[:region],
      access_key_id: PARAMS[:access_key_id],
      secret_access_key: PARAMS[:secret_access_key]
    )
    resource = Aws::SNS::Resource.new(
      client: client
    )
    @topic = resource.topic(PARAMS[:topic])
  end

  def publish(shipment)
    begin
      topic.publish(
        {
          message: {
            carrier: shipment.carrier,
            tracking_reference: shipment.tracking_reference,
            tracking_status: shipment.tracking_status
          }.to_s
        }
      )
    rescue StandardError => e
      raise SnsServiceError.new(e.message)
    end
  end
end
