# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @profile = @user.build_profile
    render :new_profile
  end

  def create_profile
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(profile_params)
    unless @profile.valid?
      render :new_profile and return
    end
    session["devise.regist_data2"] = {profile: @profile.attributes}
    @sending_destination = @user.build_sending_destination
    render :new_sending_destination
  end

  def create_sending_destination
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(session["devise.regist_data2"]["profile"])
    @sending_destination = SendingDestination.new(sending_destination_params)
    @sending_destination.phone_number = nil unless @sending_destination.phone_number.present?
    unless @sending_destination.valid?
      render :new_sending_destination and return
    end
    @user.build_profile(@profile.attributes)
    @user.build_sending_destination(@sending_destination.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    session["devise.regist_data2"]["profile"].clear
    sign_in(:user, @user)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date)
  end

  def sending_destination_params
    params.require(:sending_destination).permit(:destination_first_name, :destination_last_name, :destination_first_name_kana, :destination_last_name_kana, :post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number)
  end

  def after_update_path_for(resource)
    user_path(id: current_user.id)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
