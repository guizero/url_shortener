# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BatchCreateShortUrlsService, type: :service do
  describe '.call' do
    let(:service) { described_class.new }
    let(:urls) do
      [
        'https://www.google.com',
        'http://lets.events',
        'http://www.xerpa.com.br',
        'http://www.globo.com',
        'http://www.rockcontent.com'
      ]
    end

    subject { service.call(urls) }

    it 'creates short urls without random visits' do
      expect { subject }.to change { ShortUrl.count }.from(0).to(urls.size)
    end
  end
end
