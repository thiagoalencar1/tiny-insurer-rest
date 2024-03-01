class V1::PoliciesController < ApplicationController
  before_action :set_policy, only: [:show, :update, :destroy]
  def index
    @policies = Policy.all
    render json: @policies.to_json(include: [:insured, :vehicle])
  end

  def show
    render json: @policy.to_json(include: [:insured, :vehicle])
  end

  def create
    @policy = Policy.new(policy_params)

    if policy.save
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
    params.require(:policy).permit(:insured_at, :insured_until, :insured, :vechicle)
  end
end
