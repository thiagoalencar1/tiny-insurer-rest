class InsuredsController < ApplicationController
  def index
    @insureds = Insured.all
    render json: @insureds
  end

  def show
    @insured = Insured.find(params[:id])
    render json: @insured
  end
end
