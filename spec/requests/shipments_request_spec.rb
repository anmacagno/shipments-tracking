require 'rails_helper'

RSpec.describe 'Shipments', type: :request do
  describe 'POST /shipments' do
    context 'when the request is valid' do
      let(:params) { { shipment: { carrier: 'sandbox', tracking_reference: '123456' } } }
      before { post '/shipments', params: params }

      it 'creates a shipment' do
        json = JSON.parse(response.body)
        expect(json['carrier']).to eq('sandbox')
        expect(json['tracking_reference']).to eq('123456')
        expect(json['tracking_status']).to eq('created')
        expect(json['notification_status']).to eq('pending')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:params) { {} }
      before { post '/shipments', params: params }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation error message' do
        expect(response.body).to match(
          "[\"Carrier can't be blank\",\"Tracking reference can't be blank\"]"
        )
      end
    end
  end
end
