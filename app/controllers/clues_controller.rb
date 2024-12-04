class CluesController < ApplicationController
  def show
    render json: { "action": "show" }
  end

  def index
    render json: { "action": "index" }
  end

  def create
    render json: { "action": "create" }
  end
end
