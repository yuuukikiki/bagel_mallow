class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  private

  def authenticate_admin!
    authenticate_admin!
  end
end
