require 'rails_helper'

RSpec.describe Shipment, type: :model do
  describe 'enums' do
    it do
      should define_enum_for(:tracking_status).
        backed_by_column_of_type(:string).
        with_values([:created, :on_transit, :delivered, :exception]).
        with_prefix(:tracking_status)
    end
    it do
      should define_enum_for(:notification_status).
        backed_by_column_of_type(:string).
        with_values([:pending, :published]).
        with_prefix(:notification_status)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:carrier) }
    it { should validate_presence_of(:tracking_reference) }
    it { should validate_inclusion_of(:carrier).in_array(%w[sandbox fedex]) }
  end
end
