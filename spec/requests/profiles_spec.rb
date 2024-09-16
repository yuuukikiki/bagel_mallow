require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/profiles/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /order_history" do
    it "returns http success" do
      get "/profiles/order_history"
      expect(response).to have_http_status(:success)
    end
  end

end
