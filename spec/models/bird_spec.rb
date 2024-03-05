require 'rails_helper'
require './spec/support/bird_helper.rb'
require './spec/support/node_helper.rb'

RSpec.describe Bird, type: :model do
  before :all do
    seed_test_nodes
    seed_test_birds
  end

  describe ".ids_on_branches" do

    specify "returns bird ids on the same tree" do
      expect(Bird.ids_on_branches([125, 5497637]).sort).to eq(
        [3, 4, 5]
      )
    end

    specify "returns bird ids on different trees" do
      expect(Bird.ids_on_branches([125, 9]).sort).to eq(
        [3, 4, 5, 6]
      )
    end

    specify "returns bird ids from circlular references" do
      expect(Bird.ids_on_branches([1234]).sort).to eq(
        [7, 8, 9]
      )
    end
  end
end
