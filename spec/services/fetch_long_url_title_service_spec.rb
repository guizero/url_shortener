# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchLongUrlTitleService, type: :service do
  describe '.call' do
    let(:service) { described_class.new }

    subject { service.call(url) }

    describe 'with valid URL' do
      before { allow(service).to receive(:open).and_return(returned_html) }

      context 'with title tag' do
        let(:url) { 'https://www.google.com' }
        let(:returned_html) { '<title>Google - The new search</title>' }

        it { is_expected.to eq 'Google - The new search' }
      end

      context 'without title tag' do
        let(:url) { 'https://www.pagewithouttitle.com' }
        let(:returned_html) { '<html>This page has no title</html>' }

        it { is_expected.to eq 'Title not present or not found' }
      end
    end

    describe 'with invalid URL' do
      let(:url) { nil }

      it { is_expected.to eq 'Title not present or not found' }
    end
  end
end
