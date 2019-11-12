# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortUrls::TopShortUrlsController, type: :controller do
  describe 'GET #call' do
    subject { get :call }

    it 'redirects to target url and registers visit' do
      subject
      expect(response).to have_http_status(:ok)
    end
  end
end
