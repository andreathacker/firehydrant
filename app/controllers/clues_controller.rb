class CluesController < ApplicationController

  def create
    @clue = Clue.new(clue_params)
    if @clue.save
      render json: @clue, status: :created
    else
      render json: @clue.errors, status: :unprocessable_entity
    end
  end

  def index
    @clues = Clue.all
    render json: @clues
  end

  def show
    @clue = Clue.find(params[:id])
    render json: @clue
  end

  def destroy
    @clue = Clue.find(params[:id])
    @clue.destroy
    head :no_content
  end

  private

  def clue_params
    params.require(:clue).permit(:incident_id, :event_id)
  end
end
