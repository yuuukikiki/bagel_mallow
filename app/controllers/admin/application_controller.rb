class Admin::ApplicationController < ActionController::Base
  layout 'admin' # 管理者用レイアウトを指定
  before_action :authenticate_admin! # 管理者認証
end
