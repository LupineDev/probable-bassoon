class CommonAncestorController < ApplicationController
  def index
    if params[:a] && params[:b]
      result = Node.lowest_common_ancestor(params[:a], params[:b])
      render json: result
    else
      render json: {error: "Missing parameter(s), both 'a' and 'b' are required"}, status: 400
    end
  end
end
