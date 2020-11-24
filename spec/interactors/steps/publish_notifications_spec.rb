require 'rails_helper'

RSpec.describe Steps::PublishNotifications, type: :interactor do
  subject(:context) { described_class.call(shipments: shipments, statuses: statuses) }

  describe '.call' do
    context 'without shipments' do
      let(:shipments) { [] }
      let(:statuses) { {} }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides published' do
        expect(context.published.size).to eq(0)
      end
    end

    context 'with shipments' do
      before do
        allow_any_instance_of(SnsService).to receive(:publish).and_return(true)
      end

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

      it 'provides published' do
        expect(context.published.size).to eq(2)
      end
    end
  end
end
