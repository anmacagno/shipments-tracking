require 'rails_helper'

RSpec.describe Trackers::SandboxTracker, type: :factory do
  describe '#track_status' do
    let(:shipment) { Shipment.new(carrier: 'sandbox', tracking_reference: '123456') }
    let(:subject) { described_class.new(shipment) }

    it 'should return the correct status' do
      expect(subject.track_status).to eq(Shipment.tracking_statuses[:delivered])
    end
  end
end
