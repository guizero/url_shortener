Rails.application.routes.draw do
  scope module: :short_urls, action: :call do
    get  "/:short_code", controller: "redirect"
  end
end
