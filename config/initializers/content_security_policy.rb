# Be sure to restart your server when you modify this file.

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src    :self, :https, 'https://fonts.googleapis.com', 'https://fonts.gstatic.com'
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.script_src  :self, :https, 'https://js.pay.jp'
    policy.style_src   :self, :https, 'https://fonts.googleapis.com', "'unsafe-inline'"
    policy.style_src_elem :self, :https, 'https://fonts.googleapis.com'  # これを追加
    # policy.report_uri "/csp-violation-report-endpoint"
  end

  config.content_security_policy_nonce_generator = ->(request) { SecureRandom.base64(16) }
  config.content_security_policy_nonce_directives = %w(script-src)

  # CSP違反の報告のみを行いたい場合（オプション）
  # config.content_security_policy_report_only = true
end