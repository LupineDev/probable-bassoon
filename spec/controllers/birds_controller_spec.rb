require 'rails_helper'

require './spec/support/node_helper.rb'
require './spec/support/bird_helper.rb'

RSpec.describe BirdsController, type: :controller do
  before :all do
    seed_test_nodes
    seed_test_birds
  end

  describe "GET#index" do
    specify "takes an array of node_ids and returns ids of birds belonging to nodes or their descendants" do
      get :index, params: {node_ids: [125, 2820230, 9]}
      expect(response.body).to eq({bird_ids: [6,3,4,5]}.to_json)
      expect(response.status).to eq(200)
    end

    specify "returns 400 status if missing a parameter" do
      get :index, params: {}
      expect(response.body).to eq({error: "Missing parameter 'node_ids' is required"}.to_json)
      expect(response.status).to eq(400)
    end
  end
end
