require 'rails_helper'

RSpec.describe Trackers::FedexTracker, type: :factory do
  describe '#track_status' do
    before do
      tracking_information = Fedex::TrackingInformation.new(status_description: 'delivered')
      allow_any_instance_of(FedexService).to receive(:track).and_return(tracking_information)
    end

    let(:shipment) { Shipment.new(carrier: 'fedex', tracking_reference: '123456') }
    let(:subject) { described_class.new(shipment) }

    it 'should return the correct status' do
      expect(subject.track_status).to eq('delivered')
    end
  end
end
