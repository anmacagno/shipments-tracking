class FedexService
  include Singleton

  PARAMS = {
    key: 'O21wEWKhdDn2SYyb',
    password: 'db0SYxXWWh0bgRSN7Ikg9Vunz',
    account_number: '510087780',
    meter: '119009727',
    mode: 'test'
  }

  private_constant :PARAMS

  attr_accessor :shipment

  def initialize
    @shipment = Fedex::Shipment.new(PARAMS)
  end

  def track(tracking_number)
    begin
      shipment.track(tracking_number: tracking_number).first
    rescue StandardError => e
      raise FedexServiceError.new(e.message)
    end
  end
end
