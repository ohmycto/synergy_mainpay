Rails.application.routes.draw do
  namespace :gateway do
    match '/mainpay/:gateway_id/:order_id' => 'mainpay#show', :as => :mainpay
  end

end
