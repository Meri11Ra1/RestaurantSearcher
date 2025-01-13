require 'rails_helper'

RSpec.describe "SearchConditions", type: :request do
  describe "GET /search_condition" do
    it "responds with 200" do
      get "/search_condition/index"
      expect(response).to have_http_status(200)
    end
  end
end
