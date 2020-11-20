require 'rails_helper'

RSpec.describe Trackers::BaseTracker, type: :factory do
  describe '#track_status' do
    let(:subject) { described_class.new(nil) }

    it 'should raise NotImplementedError error' do
      expect { subject.track_status }.to raise_error(NotImplementedError)
    end
  end
end
