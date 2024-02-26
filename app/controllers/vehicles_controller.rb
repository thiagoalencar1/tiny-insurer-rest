class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :update, :destroy]
  def index
    @vehicles = Vehicle.all
    render json: @vehicles
  end

  def show
    render json: @vehicle
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      render json: @vehicle, status: :created, location: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  def update
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @vehicle.destroy
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.permit(:plate, :brand, :model, :year)
  end
end
