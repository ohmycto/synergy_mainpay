class Gateway::MainpayController < Spree::BaseController
  ssl_required :show
  
  def show
    @order = Order.find(params[:order_id])
    @gateway = @order.available_payment_methods.find { |x| x.id == params[:gateway_id].to_i }

    unless @order || @gateway
      flash[:error] = t('.invalid_arguments')
      redirect_to :back
    end

  end

end
