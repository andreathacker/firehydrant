class CluesController < ApplicationController
  def index
    render json: { "action": "index" }
  end

  def show
    render json: { "action": "show" }
  end

  def create
    render json: { "action": "create" }
  end
end
