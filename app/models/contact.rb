class Contact < ApplicationRecord
  validates :name, presence: { message: I18n.t('errors.messages.blank') }
  validates :email, presence: { message: I18n.t('errors.messages.blank') },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t('errors.messages.email_invalid') }
  validates :message, presence: { message: I18n.t('errors.messages.blank') }
end
