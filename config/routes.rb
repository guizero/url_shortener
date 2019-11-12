# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'

  scope module: :short_urls, action: :call do
    get  '/',            controller: 'create'
    post '/',            controller: 'generator'
    get  '/top-urls',    controller: 'top_short_urls'
    get  '/:short_code', controller: 'redirect'
  end
end
