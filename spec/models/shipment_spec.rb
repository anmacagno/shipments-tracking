require 'rails_helper'

RSpec.describe Shipment, type: :model do
  describe 'constants' do
    it 'has CARRIERS constant' do
      expect(described_class::CARRIERS).to eq(%w[sandbox fedex])
    end
  end

  describe 'enums' do
    it do
      should define_enum_for(:tracking_status).
        backed_by_column_of_type(:string).
        with_values(
          {
            created: 'created',
            on_transit: 'on_transit',
            delivered: 'delivered',
            exception: 'exception'
          }
        ).
        with_prefix(:tracking_status)
    end

    it do
      should define_enum_for(:notification_status).
        backed_by_column_of_type(:string).
        with_values(
          {
            pending: 'pending',
            published: 'published'
          }
        ).
        with_prefix(:notification_status)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:carrier) }
    it { should validate_presence_of(:tracking_reference) }
    it { should validate_inclusion_of(:carrier).in_array(described_class::CARRIERS) }
  end
end
