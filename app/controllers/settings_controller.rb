class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
  end

  def delete_account
    current_user.destroy
    redirect_to root_path, notice: t('settings.account_deleted', default: 'Your account has been successfully deleted.')
  end
end
