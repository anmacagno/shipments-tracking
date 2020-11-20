require 'rails_helper'

RSpec.describe Trackers::FedexTracker, type: :factory do
  describe '#track_status' do
    let(:subject) { described_class.new(nil) }

    it 'should return the correct status' do
      expect(subject.track_status).to eq('exception')
    end
  end
end
