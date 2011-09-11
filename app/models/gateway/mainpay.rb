class Gateway::Mainpay < Gateway
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

  def input_url
    'https://partner.mainpay.ru/a1lite/input'
  end

  def desc
    "<p>
      <label>#{I18n.t('success_url')}:</label> http://[domain]/gateway/mainpay/success<br />
      <label>#{I18n.t('fail_url')}:</label> http://[domain]/gateway/mainpay/fail<br />
      <label>#{I18n.t('handler_url')}:</label> http://[domain]/gateway/mainpay/handler<br />
    </p>"
  end

end
