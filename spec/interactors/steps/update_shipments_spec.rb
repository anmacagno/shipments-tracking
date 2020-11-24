require 'rails_helper'

RSpec.describe Steps::UpdateShipments, type: :interactor do
  subject(:context) { described_class.call(shipments: shipments, statuses: statuses) }

  describe '.call' do
    context 'without shipments' do
      let(:shipments) { [] }
      let(:statuses) { {} }

      it 'succeeds' do
        expect(context).to be_a_success
      end
    end

    context 'with shipments' do
      let(:shipments) {
        [
          Shipment.new(id: 1, carrier: 'sandbox', tracking_reference: '001'),
          Shipment.new(id: 2, carrier: 'sandbox', tracking_reference: '002')
        ]
      }
      let(:statuses) {
        {
          1 => 'on_transit',
          2 => 'on_transit'
        }
      }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'updates shipments' do
        expect(context.shipments[0].tracking_status).to eq('on_transit')
        expect(context.shipments[1].tracking_status).to eq('on_transit')
      end
    end
  end
end
