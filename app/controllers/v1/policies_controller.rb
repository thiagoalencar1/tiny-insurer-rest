# frozen_string_literal: true

class V1::PoliciesController < ApplicationController
  before_action :set_policy, only: [:show, :update, :destroy]
  before_action :authenticate_request

  def index
    @policies = Policy.all.includes(:insured, :vehicle).sort_by(&:id)
    render json: @policies, include: [:insured, :vehicle]
  end

  def show
    render json: @policy, include: [:insured, :vehicle]
  end

  def create
    @policy = Policy.new(policy_params)

    if @policy.save
      render json: @policy, status: :created, location: @policy
    else
      render json: @policy.errors, status: :unprocessable_entity
    end
  end

  def update
    if @policy.update(policy_params)
      render json: @policy
    else
      render json: @policy.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @policy.destroy
  end

  private
 
  def set_policy
    @policy = Policy.find(params[:id])
  end

  def policy_params
    params.require(:policy).permit(:insured_at, :insured_until, :status, :insured, :vehicle)
  end

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      JWT.decode(token, 'secret', true, algorithm: 'HS256')
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
