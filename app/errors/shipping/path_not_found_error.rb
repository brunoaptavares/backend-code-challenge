class Shipping::PathNotFoundError < StandardError

  def initialize(msg='Path not found')
    super
  end
end
