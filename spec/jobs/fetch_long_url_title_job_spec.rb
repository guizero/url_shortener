# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchLongUrlTitleJob, type: :job do
  describe '.perform' do
    let(:short_id) { double('ShortUrl', long_url: 'a long url') }

    subject { described_class.new.perform(short_id) }

    before do
      allow(FetchLongUrlTitleService).to receive(:call).and_return('a title')
    end

    it 'updates the provided short url with the fetched title' do
      expect(short_id).to receive(:update).with(title: 'a title')
      subject
    end
  end
end
