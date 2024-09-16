module Admin
  class SettingsController < ApplicationController
    before_action :authenticate_admin!

    def edit
      @settings = SiteSettings.first || SiteSettings.new
    end

    def update
      @settings = SiteSettings.first || SiteSettings.new(settings_params)
      if @settings.update(settings_params)
        redirect_to edit_admin_settings_path, notice: '設定が更新されました。'
      else
        render :edit
      end
    end

    private

    def settings_params
      params.require(:site_settings).permit(:site_name, :contact_email, :other_settings)
    end
  end
end
