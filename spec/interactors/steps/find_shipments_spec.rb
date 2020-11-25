require 'rails_helper'

RSpec.describe Steps::FindShipments, type: :interactor do
  subject(:context) { described_class.call(carrier: carrier) }

  describe '.call' do
    context 'with valid params' do
      before do
        Shipment.create(
          [
            { carrier: 'fedex', tracking_reference: '001' },
            { carrier: 'fedex', tracking_reference: '002' }
          ]
        )
      end

      let(:carrier) { 'fedex' }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides shipments' do
        expect(context.shipments.size).to eq(2)
      end
    end

    context 'with invalid params' do
      let(:carrier) { 'dhl' }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides an error' do
        expect(context.error).to be_present
      end
    end
  end
end
