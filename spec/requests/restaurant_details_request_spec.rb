require 'rails_helper'

RSpec.describe "RestaurantDetails", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/restaurant_details/index"
      expect(response).to have_http_status(:success)
    end
  end

end
