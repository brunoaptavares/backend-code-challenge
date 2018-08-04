class DistanceController < ApplicationController

  def create
    @distance = find_or_initialize
    raise ActiveRecord::RecordInvalid if !@distance.update(distance_params)

    json_response(@distance, :created)
  end

  private

  def distance_params
    params.permit(:point_a, :point_b, :distance)
  end

  def find_or_initialize
    Distance.where('point_a = ? AND point_b = ?', distance_params[:point_a], distance_params[:point_b]).first_or_initialize(distance_params)
  end
end
