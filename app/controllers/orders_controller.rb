class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
    @user_info = UserInfo.find_by(user_id: current_user.id)
  end

  def submit
  end
end
