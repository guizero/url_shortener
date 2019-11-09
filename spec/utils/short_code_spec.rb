# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortCode, type: :utils do
  describe '.encode and .decode' do
    shared_examples 'a correct encoding / decoding' do |integer|
      encoded = described_class.encode(integer)
      decoded = described_class.decode(encoded).to_i

      it "is works with #{integer}" do
        expect(integer).to eq(decoded)
      end
    end

    it_behaves_like 'a correct encoding / decoding', 1

    100.times do
      it_behaves_like 'a correct encoding / decoding', rand(1000000000)
    end
  end

  describe '.valid?' do
    let(:invalid_type) { 2 }
    let(:invalid_chars) { '12345b'}
    let(:valid_string) {'2345b'}

    it { expect(described_class.valid?(invalid_type)).to be false }
    it { expect(described_class.valid?(invalid_chars)).to be false }
    it { expect(described_class.valid?(valid_string)).to be true }
  end
end
