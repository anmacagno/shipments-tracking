require 'rails_helper'

RSpec.describe TrackerFactory, type: :factory do
  describe 'constants' do
    it 'has TRACKERS constant' do
      expect(described_class::TRACKERS).to eq(
        {
          sandbox: Trackers::SandboxTracker,
          fedex: Trackers::FedexTracker
        }
      )
    end
  end

  describe '.for' do
    context 'with carrier sandbox' do
      let(:tracker) { described_class.for('sandbox', nil) }

      it 'should return the correct class' do
        expect(tracker).to be_instance_of(Trackers::SandboxTracker)
      end
    end

    context 'with carrier fedex' do
      let(:tracker) { described_class.for('fedex', nil) }

      it 'should return the correct class' do
        expect(tracker).to be_instance_of(Trackers::FedexTracker)
      end
    end

    context 'with carrier dhl' do
      let(:tracker) { described_class.for('dhl', nil) }

      it 'should return nil' do
        expect(tracker).to be_nil
      end
    end
  end
end
