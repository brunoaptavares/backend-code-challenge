class ShippingController < ApplicationController

  def show
    @shipping = Shipping.new(shipping_params)
    raise ActiveRecord::RecordInvalid if !@shipping.valid?

    json_response(@shipping, :ok)
  end

  private

  def shipping_params
    params.permit(:origin, :destination, :weight)
  end
end
