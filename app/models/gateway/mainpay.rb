class Gateway::Mainpay < Gateway
  Urls = { :success_url => 'success', :fail_url => 'fail', :handler_url => 'handler' }
  Urls.each do |key, value|
    define_method(key) { "http://[domain]/gateway/mainpay/#{value}" }
  end

  preference :secret1, :string
  preference :secret2, :string

  def provider_class
    self.class
  end

  def method_type
    'mainpay'
  end
  
  def self.current
    self.where(:type => self.to_s, :environment => Rails.env, :active => true).first
  end

  def urls
    Urls
  end

  def input_url
    'https://partner.mainpay.ru/a1lite/input'
  end

end
