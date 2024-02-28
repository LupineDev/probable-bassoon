require 'rails_helper'
require './spec/support/node_helper.rb'

RSpec.describe Node, type: :model do
  before :all do
    seed_test_nodes
  end

  describe ".lowest_common_ancestor" do
    specify "returns nil if no common ancestor" do
      result = Node.lowest_common_ancestor(9, 4430546)
      expect(result).to eq({root_id: nil, lowest_common_ancestor: nil, depth: nil})
    end

    specify "returns nil if either node is not found" do
      result = Node.lowest_common_ancestor(42, 4430546)
      expect(result).to eq({root_id: nil, lowest_common_ancestor: nil, depth: nil})
    end

    specify "finds common ancestors at depth of 1" do
      result = Node.lowest_common_ancestor(5497637, 130)
      expect(result).to eq({root_id: 130, lowest_common_ancestor: 130, depth: 1})
    end

    specify "finds common ancestors at depth of 2" do
      result = Node.lowest_common_ancestor(5497637, 2820230)
      expect(result).to eq({root_id: 130, lowest_common_ancestor: 125, depth: 2})
    end

    specify "finds common ancestors at depth of 3" do
      result = Node.lowest_common_ancestor(5497637, 4430546)
      expect(result).to eq({root_id: 130, lowest_common_ancestor: 4430546, depth: 3})
    end

    specify "returns the node if a and b are the same node" do
      result = Node.lowest_common_ancestor(4430546, 4430546)
      expect(result).to eq({root_id: 130, lowest_common_ancestor: 4430546, depth: 3})
    end
  end

  describe ".descendant_ids" do
    specify "returns an  array of child ids, children's child ids... etc  including their own" do
      expect(Node.descendant_ids([125, 4430546]).sort).to eq([125, 2820230, 4430546, 5497637].sort)
      expect(Node.descendant_ids([4430546]).sort).to eq([4430546, 5497637].sort)
    end

    specify "returns an array of only itself if no child nodes exist" do
      expect(Node.descendant_ids([9]).sort).to eq([9])
    end
  end

  describe "#ancestor_ids" do
    specify "returns a descending array of ancestor ids starting from root, ending with itself" do
      n1 = Node.find(5497637)
      expect(n1.ancestor_ids).to eq([130, 125, 4430546, 5497637])
      n2 = Node.find(2820230)
      expect(n2.ancestor_ids).to eq([130, 125, 2820230])
    end

    specify "raises an exception when node data is cyclical" do
      expect {
        Node.find(1234).ancestor_ids
      }.to raise_error(Node::BootstrapParadoxError)
    end
  end
end
