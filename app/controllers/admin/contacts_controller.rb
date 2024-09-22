module Admin
  class ContactsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_contact, only: [:show, :destroy]

    def index
      @contacts = Contact.all
    end

    def show
    end

    def destroy
      @contact.destroy
      redirect_to admin_contacts_path, notice: 'お問い合わせが削除されました。'
    end

    private

    def set_contact
      @contact = Contact.find(params[:id])
    end
  end
end
