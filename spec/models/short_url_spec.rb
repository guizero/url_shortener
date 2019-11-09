# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:long_url) }
    it { should validate_length_of(:long_url).is_at_least(5).is_at_most(2000) }

    describe '.long_url_must_be_valid' do
      shared_examples 'an invalid long_url' do |long_url|
        let(:short_url) { described_class.new(long_url: long_url) }

        it 'is invalid' do
          expect(subject.valid?).to be false
          expect(subject.errors.full_messages).to include 'The provided URL is not valid'
        end
      end

      shared_examples 'a valid long_url' do |long_url|
        let(:short_url) { described_class.new(long_url: long_url) }

        it 'is valid' do
          expect(short_url.valid?).to be true
        end
      end

      context 'with valid URLs' do
        it_behaves_like 'a valid long_url', 'https://bluecoding.com'
        it_behaves_like 'a valid long_url', 'http://bluecoding.com'
        it_behaves_like 'a valid long_url', 'http://address.com/path?query=true#referece'
      end

      context 'with invalid URLs' do
        it_behaves_like 'an invalid long_url', ''
        it_behaves_like 'an invalid long_url', 'bluecoding.com'
        it_behaves_like 'an invalid long_url', 'rsync://bluecoding.com'
        it_behaves_like 'an invalid long_url', 'file:///home/bluecoding/tmp'
        it_behaves_like 'an invalid long_url', 'ftp://bluecoding.com/linux/debian'
      end
    end
  end
end
