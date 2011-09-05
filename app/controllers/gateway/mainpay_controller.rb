class Gateway::MainpayController < Spree::BaseController
  ssl_required :show
  before_filter :find_order_and_gateway, :only => [ :handler, :success, :fail ]
  skip_before_filter :verify_authenticity_token, :only => [ :handler, :success, :fail ]
  
  def show
    @order = Order.find(params[:order_id])
    @gateway = @order.available_payment_methods.find { |x| x.id == params[:gateway_id].to_i }

    unless @order || @gateway
      flash[:error] = t('.invalid_arguments')
      redirect_to :back
    end

  end

  def handler
   if @order && @gateway && response_valid?
     payment = @order.payments.build(:payment_method => @order.payment_method)
     payment.state  = 'completed'
     payment.amount = params[:system_income].to_f
     payment.save

     @order.save!
     @order.next! until @order.state == 'complete'
     @order.update!

     render :text => "OK#{@order.id}"

   else
     render :text => 'Bad response'
   end

  end

  def success
    if @order && @gateway && response_valid? && @order.complete?
      session[:order_id] = nil
      redirect_to order_path(@order), t('.payment_success')
    else
      flash[:error] = t('.payment_fail')
      redirect_to root_url
    end
  end

  def fail
    flash[:error] = t('.payment_fail')
    redirect_to @order.blank? ? root_url : checkout_state_path('payment')
  end

  private

  def find_order_and_gateway
    @order = Order.find_by_id(params[:comment])
    @gateway = Gateway::Mainpay.current
  end

  def response_valid?
    unless params[:system_income].to_f == @order.total
      return false
    end

    joined_params = [
      params[:tid],
      params[:name],
      params[:comment],
      params[:partner_id],
      params[:service_id],
      params[:order_id],
      params[:type],
      params[:partner_income],
      params[:system_income],
      params[:test],
      @gateway.options[:secret2]
    ].join

    unless params[:check].downcase == Digest::MD5.hexdigest(joined_params).downcase
      return false
    end
      
    true

  end

end
