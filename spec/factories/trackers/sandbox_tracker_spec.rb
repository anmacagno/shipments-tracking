require 'rails_helper'

RSpec.describe Trackers::SandboxTracker, type: :factory do
  describe '#track_status' do
    let(:subject) { described_class.new(nil) }

    it 'should return the correct status' do
      expect(subject.track_status).to eq('delivered')
    end
  end
end
