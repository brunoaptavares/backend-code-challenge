class Distance < ApplicationRecord

  validates :point_a, :point_b, :distance, presence: true
  validate do |d|
    errors.add(:distance, 'Invalid distance to transport') if d.distance.present? && (d.distance < min_distance || d.distance > max_distance)
  end

  private

  def min_distance
    @min_distance ||= distance_config.min
  end

  def max_distance
    @max_distance ||= distance_config.max
  end

  def distance_config
    @config ||= AppConfig.config.distance
  end
end
