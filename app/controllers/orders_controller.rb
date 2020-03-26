class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_new_order, only: [:paypal_create_payment]

  FAILURE_MESSAGE = 'Something went wrong'
  SUCCESS_MESSAGE = 'Your order was placed successfully!'

  def index
    @products = Product.all
    @products_subscription = Product.all
    @user_info = UserInfo.find_by(user_id: current_user.id)
  end

  def paypal_create_payment
    PayPal::SDK::REST.set_config(
      :mode => "sandbox",
      :client_id => ENV['PAYPAL_CLIENT_ID'],
      :client_secret => ENV['PAYPAL_CLIENT_SECRET'])

    result = Orders::Paypal.create_payment(order: @order, product: @product)
    if result
      render json: { token: result }, status: :ok
    else
      render json: {error: FAILURE_MESSAGE}, status: :unprocessable_entity
    end
  end

  def paypal_execute_payment
    if Orders::Paypal.execute_payment(payment_id: params[:paymentID], payer_id: params[:payerID])
      render json: {}, status: :ok
    else
      render json: {error: FAILURE_MESSAGE}, status: :unprocessable_entity
    end
  end

  def submit
    @order = Orders::Paypal.finish(order_params[:charge_id])
  ensure
    if @order&.save
      if @order.paid?
        return render html: SUCCESS_MESSAGE
      elsif @order.failed? && !@order.error_message.blank?
        return render html: @order.error_message
      end
    end
    render html: FAILURE_MESSAGE
  end

  private

  def prepare_new_order
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @product = Product.find(@order.product_id)
    @order.price_cents = @product.price_cents
  end

  def order_params
    params.require(:orders).permit(
      :product_id,
      :token,
      :charge_id
    )
  end
end
