# Be sure to restart your server when you modify this file.

Rails.application.configure do
  config.content_security_policy do |policy|
    # デフォルトのリソースロード許可
    policy.default_src :self, :https

    # フォントの読み込みを許可（Google Fonts用）
    policy.font_src    :self, :https, 'https://fonts.googleapis.com', 'https://fonts.gstatic.com'

    # 画像の読み込みを許可
    policy.img_src     :self, :https, :data

    # オブジェクト埋め込みの禁止
    policy.object_src  :none

    # スクリプトの読み込みを許可（PAY.JPのスクリプトも含む）
    policy.script_src  :self, :https, 'https://js.pay.jp', "'unsafe-inline'"

    # スタイルシートの読み込みを許可し、インラインスタイルを許可
    policy.style_src   :self, :https, 'https://fonts.googleapis.com', "'unsafe-inline'"

    # policy.report_uri "/csp-violation-report-endpoint"
  end

    # インラインスクリプト・スタイルでのnonce生成
  config.content_security_policy_nonce_generator = ->(request) { SecureRandom.base64(16) }
  config.content_security_policy_nonce_directives = %w(script-src)

  # CSP違反の報告のみを行いたい場合（オプション）
  # config.content_security_policy_report_only = true
end