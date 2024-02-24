class BirdsController < ApplicationController
  def index
    if params[:node_ids]
      node_ids = Node.descendant_ids(params[:node_ids])
      bird_ids = Bird.where(node_id: node_ids).ids
      render json: {bird_ids: bird_ids}
    else
      render json: {error: "Missing parameter 'node_ids' is required"}, status: 400
    end
  end
end
