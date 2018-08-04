require 'dijkstra'

class Shipping
  include Virtus.model
  include ActiveModel::Validations

  attribute :origin,      String
  attribute :destination, String
  attribute :weight,      Integer
  attribute :cost,        Float

  validates :origin, :destination, :weight, presence: true
  validate do |c|
    errors.add(:weight, 'Invalid weight to transport') if c.weight.present? && (c.weight < min_weight || c.weight > max_weight)
  end

  def cost
    raise Shipping::PathNotFoundError if shortest_distance == 0 || !shortest_distance.is_a?(Integer)
    shortest_distance * weight * rate
  end

  private

  def shortest_distance
    @shortest_distance ||= Dijkstra.new(origin, destination, Distance.pluck(:point_a, :point_b, :distance)).cost
  end

  def min_weight
    @min_weight ||= shipping_config.min_weight
  end

  def max_weight
    @max_weight ||= shipping_config.max_weight
  end

  def rate
    @rate ||= shipping_config.rate
  end

  def shipping_config
    @config ||= AppConfig.config.shipping
  end
end
