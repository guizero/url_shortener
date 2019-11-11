# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe 'validations' do
    it { should have_many(:visits).dependent(:destroy) }
    it { should validate_presence_of(:long_url) }
    it { should validate_length_of(:long_url).is_at_least(5).is_at_most(2000) }

    describe 'long_url_must_be_valid' do
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

  describe 'callbacks' do
    it 'after_save calls the fetch title job' do
      ActiveJob::Base.queue_adapter = :test
      short_url = described_class.create(long_url: 'https://bluecoding.com')
      expect(FetchLongUrlTitleJob).to have_been_enqueued.with(short_url).on_queue('default')
    end
  end

  describe '.find_from_code' do
    let(:short_url) { ShortUrl.create(long_url: 'https://www.bluecoding.com') }
    let(:code) { ShortCode.encode(short_url.id) }

    subject { described_class.find_from_code(code) }

    it { is_expected.to eq short_url }

    context 'code is invalid' do
      before { allow(ShortCode).to receive(:valid?).and_return(false) }

      it { is_expected.to be_nil }
    end
  end

  describe '#short_id' do
    let(:long_url) { 'https://www.bluecoding.com' }
    let(:short_url) { described_class.create(long_url: long_url) }

    subject { short_url.short_id }

    it 'calls the short url utils' do
      expect(ShortCode)
        .to receive(:encode)
        .with(short_url.id)
        .once

      subject
    end
  end

  describe '#register_new_visit' do
    let!(:short_url) { described_class.create(long_url: 'https://www.google.com') }

    subject { short_url.register_new_visit(ip_address) }

    it 'has no visit' do
      expect(short_url.visits_count).to eq 0
    end

    context 'when the visitor ip is nil' do
      let(:ip_address) { nil }

      it 'does not register the visit' do
        expect { subject }.not_to change { short_url.visits_count }
      end
    end

    context 'when the visitor ip is blank' do
      let(:ip_address) { '' }

      it 'does not register the visit' do
        expect { subject }.not_to change { short_url.visits_count }
      end
    end

    context 'when there a register_new_visit is called' do
      let(:ip_address) { '1.2.3.4' }

      it 'counts the visit' do
        expect { subject }.to change { short_url.visits_count }.from(0).to(1)
      end

      it 'does not count the visit from same ip twice' do
        expect { subject }.to change { short_url.visits_count }.from(0).to(1)
        expect { subject }.not_to change { short_url.visits_count }
      end
    end
  end
end
