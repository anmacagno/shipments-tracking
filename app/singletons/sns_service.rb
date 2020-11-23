class SnsService
  include Singleton

  PARAMS = {
    region: 'us-east-1',
    identity_pool_id: 'us-east-1:89b0ac5d-4e52-4a69-9939-38d03d8f1278',
    topic: 'arn:aws:sns:us-east-1:046547403683:ShipmentNotificationCreated'
  }

  private_constant :PARAMS

  attr_accessor :topic

  def initialize
    credentials = Aws::CognitoIdentity::CognitoIdentityCredentials.new(
      region: PARAMS[:region],
      identity_pool_id: PARAMS[:identity_pool_id]
    )
    client = Aws::SNS::Client.new(
      region: PARAMS[:region],
      credentials: credentials
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
