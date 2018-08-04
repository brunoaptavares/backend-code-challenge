module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :precondition_failed)
    end

    rescue_from Shipping::PathNotFoundError do |e|
      json_response({ message: e.message }, :precondition_failed)
    end
  end
end
