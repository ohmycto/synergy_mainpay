Rails.application.routes.draw do
  namespace :gateway do
    match '/mainpay/:gateway_id/:order_id' => 'mainpay#show', :as => :mainpay
    
    match '/mainpay/handler' => 'mainpay#handler'

    match '/mainpay/success' => 'mainpay#success'
    match '/mainpay/fail' => 'mainpay#fail'

  end
end
