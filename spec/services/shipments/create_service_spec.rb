require 'rails_helper'

RSpec.describe Shipments::CreateService, type: :service do
  describe '#call' do
    context 'with valid params' do
      let(:params) { { carrier: 'sandbox', tracking_reference: '123456' } }
      let(:subject) { described_class.call(params) }

      it 'should create a shipment with carrier sandbox' do
        params[:carrier] = 'sandbox'
        expect(subject.success?).to be true
        expect(subject.shipment).to be_instance_of(Shipment)
        expect(subject.errors).to be_nil
      end

      it 'should create a shipment with carrier fedex' do
        params[:carrier] = 'fedex'
        expect(subject.success?).to be true
        expect(subject.shipment).to be_instance_of(Shipment)
        expect(subject.errors).to be_nil
      end
    end

    context 'with invalid params' do
      let(:params) { { carrier: 'sandbox', tracking_reference: '123456' } }
      let(:subject) { described_class.call(params) }

      it 'should not create a shipment with an empty carrier' do
        params[:carrier] = ''
        expect(subject.success?).to be false
        expect(subject.shipment).to be_nil
        expect(subject.errors).to eq(
          ["Carrier can't be blank"]
        )
      end

      it 'should not create a shipment with carrier dhl' do
        params[:carrier] = 'dhl'
        expect(subject.success?).to be false
        expect(subject.shipment).to be_nil
        expect(subject.errors).to eq(
          ["Carrier is not included in the list"]
        )
      end

      it 'should not create a shipment with an empty tracking reference' do
        params[:tracking_reference] = ''
        expect(subject.success?).to be false
        expect(subject.shipment).to be_nil
        expect(subject.errors).to eq(
          ["Tracking reference can't be blank"]
        )
      end

      it 'should not create a shipment with an empty carrier and tracking reference' do
        params[:carrier] = ''
        params[:tracking_reference] = ''
        expect(subject.success?).to be false
        expect(subject.shipment).to be_nil
        expect(subject.errors).to eq(
          ["Carrier can't be blank", "Tracking reference can't be blank"]
        )
      end
    end
  end
end
