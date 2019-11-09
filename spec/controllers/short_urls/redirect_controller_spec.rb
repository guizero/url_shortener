# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortUrls::RedirectController, type: :controller do
  describe 'GET #call' do
    let(:short_url) { ShortUrl.create(long_url: 'https://google.com') }

    subject { get :call, params: { short_code: short_url.short_code } }

    context 'given a valid short code' do
      it 'redirects to target url' do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    shared_examples 'a failed attempt' do
      it 'fails the request and return a text with error message' do
        subject
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq('Oops, the link you have followed looks invalid.')
        expect(response.content_type).to eq('text/plain')
      end
    end

    context 'given an invalid short code' do
      let(:short_url) { double('ShortUrl', short_code: 'invalid') }

      it_behaves_like 'a failed attempt'
    end

    context 'given a valid short code with no database correspondence' do
      let(:short_url) { double('ShortUrl', short_code: 'bc23') }

      it_behaves_like 'a failed attempt'
    end
  end
end
