require 'rails_helper'

require './spec/support/node_helper.rb'

RSpec.describe CommonAncestorController, type: :controller do
  before :all do
    seed_test_nodes
  end

  describe "GET#index" do
    specify "a JSON response with correct data is returned" do
      get :index, params: {a: 9, b: 4430546}
      expect(response.body).to eq({root_id: nil, lowest_common_ancestor: nil, depth: nil}.to_json)
      expect(response.status).to eq(200)
    end

    specify "returns 400 status if missing a parameter" do
      get :index, params: {a: 9}
      expect(response.body).to eq({error: "Missing parameter(s), both 'a' and 'b' are required"}.to_json)
      expect(response.status).to eq(400)
    end
  end
end
