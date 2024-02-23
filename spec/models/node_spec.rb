require 'rails_helper'
require './spec/support/node_helper.rb'

RSpec.describe Node, type: :model do
  before :all do
    seed_test_nodes
  end

  describe ".lowest_common_ancestor" do
  end

  describe "#ancestor_ids" do
    specify "returns an array of ancestor ids in descending depth starting from root" do
      n1 = Node.find(5497637)
      expect(n1.ancestor_ids).to eq([130, 125, 4430546])
      n2 = Node.find(2820230)
      expect(n2.ancestor_ids).to eq([130, 125])
    end
  end
end
