require 'rails_helper'

RSpec.describe Steps::TrackShipments, type: :interactor do
  subject(:context) { described_class.call(carrier: 'sandbox', shipments: shipments) }

  describe '.call' do
    context 'without shipments' do
      let(:shipments) { [] }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides statuses' do
        expect(context.statuses).to eq({})
      end
    end

    context 'with shipments' do
      let(:shipments) {
        [
          Shipment.new(id: 1, carrier: 'sandbox', tracking_reference: '001'),
          Shipment.new(id: 2, carrier: 'sandbox', tracking_reference: '002')
        ]
      }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides statuses' do
        expect(context.statuses).to eq(
          {
            1 => 'delivered',
            2 => 'delivered'
          }
        )
      end
    end
  end
end
