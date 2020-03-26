class UserInfosController < ApplicationController
  def edit
    @user_info = UserInfo.find(params[:id])
  end

  def update
    user_info = UserInfo.find(params[:id])

    if user_info.update_attributes(user_info_params)
      redirect_to '/', notice: 'User information updated'
    else
      redirect_to '/', alert: 'Something went wrong!'
    end
  end

  private
  def user_info_params
    params.require(:user_info).permit(
      :first_name,
      :last_name,
      :phone_number,
      :country,
      :street,
      :zipcode,
      :state
    )
  end
end
