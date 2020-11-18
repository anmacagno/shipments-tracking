require 'rails_helper'

RSpec.describe Shipments::CreateService, type: :service do
  describe '#call' do
    context 'with valid params' do
      let(:params) { { tracking_reference: '123456' } }
      let(:subject) { described_class.call(params) }

      it 'should create a shipment for sandbox carrier' do
        params[:carrier] = 'sandbox'
        expect(subject).to be_truthy
      end

      it 'should create a shipment for fedex carrier' do
        params[:carrier] = 'fedex'
        expect(subject).to be_truthy
      end
    end

    context 'with invalid params' do
      let(:params) { { tracking_reference: '123456' } }
      let(:subject) { described_class.call(params) }

      it 'should not create a shipment for empty carrier' do
        params[:carrier] = ''
        expect(subject).to be_falsey
      end

      it 'should not create a shipment for dhl carrier' do
        params[:carrier] = 'dhl'
        expect(subject).to be_falsey
      end

      it 'should not create a shipment for empty tracking reference' do
        params[:tracking_reference] = ''
        expect(subject).to be_falsey
      end
    end
  end
end
