require 'rails_helper'

RSpec.describe Steps::FindShipments, type: :interactor do
  subject(:context) { described_class.call(carrier: carrier) }

  describe '.call' do
    context 'with valid params' do
      let(:carrier) { 'fedex' }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides shipments' do
        expect(context.shipments).to eq([])
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
