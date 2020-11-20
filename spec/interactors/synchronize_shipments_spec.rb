require 'rails_helper'

RSpec.describe SynchronizeShipments, type: :interactor do
  describe 'organize' do
    it do
      expect(described_class.organized).to eq([
        Steps::FindShipments,
        Steps::TrackShipments,
        Steps::UpdateShipments,
        Steps::PublishNotifications
      ])
    end
  end
end
