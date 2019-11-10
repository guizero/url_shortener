# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :short_urls, action: :call do
    post '/',            controller: 'generator'
    get  '/:short_code', controller: 'redirect'
  end
end
