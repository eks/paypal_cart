class UserInfosController < ApplicationController
  def update
    user_info = UserInfo.find(params[:id])

    if user_info.update_attributes(params[:user_info])
      redirect_to root_path, notice: 'User information updated'
    else
      redirect_to :back
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
