# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortUrls::GeneratorController, type: :controller do
  describe 'POST #call' do
    describe 'success request' do
      let(:long_url) { 'http://www.google.com' }
      let(:short_url) { ShortUrl.create(long_url: long_url) }

      before { allow(ShortUrl).to receive(:new).and_return(short_url) }

      it 'returns http success and return short code and id' do
        post :call, params: { long_url: long_url }
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON(response.parsed_body)).to eq(
          'id' => short_url.id, 'short_code' => short_url.short_code
        )
      end
    end

    describe 'failure requests' do
      shared_examples 'a failed request' do
        it 'returns an error' do
          post :call, params: { long_url: long_url }
          expect(response).to have_http_status(:bad_request)
          expect(response.content_type).to eq('application/json')
          expect(JSON(response.parsed_body)['errors']).to include(expected_error)
        end
      end

      context 'given a invalid URI' do
        let(:long_url) { 'foobar' }
        let(:expected_error) { { 'base' => ['The provided URL is not valid'] } }

        it_behaves_like 'a failed request'
      end

      context 'given a very long URI' do
        let(:long_url) { "http://#{('y' * 2000)}.com" }
        let(:expected_error) { { 'long_url' => ['is too long (maximum is 2000 characters)'] } }

        it_behaves_like 'a failed request'
      end


      it 'returns error if target parameter is not present in the request' do
        post :call, params: { other_parameter: 'foo.com' }
        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq('application/json')
        expect(JSON(response.parsed_body)).to eq('errors' => { 'target' => ['is not present'] })
      end

      context 'given a empty long URI' do
        let(:long_url) { '' }
        let(:expected_error) { { 'long_url' => ["can't be blank", 'is too short (minimum is 5 characters)'] } }

        it_behaves_like 'a failed request'
      end
    end
  end
end
