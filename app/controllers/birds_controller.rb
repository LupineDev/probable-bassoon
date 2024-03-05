class BirdsController < ApplicationController
  def index
    if params[:node_ids]
      bird_ids = Bird.ids_on_branches(params[:node_ids])
      render json: {bird_ids: bird_ids}
    else
      render json: {error: "Missing parameter 'node_ids' is required"}, status: 400
    end
  end
end
