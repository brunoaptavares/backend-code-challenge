require 'rails_helper'

RSpec.describe ShippingController, type: :controller do

  describe 'GET cost' do
    let(:instance)    { described_class.new }
    let(:origin)      { 'A' }
    let(:destination) { 'B' }
    let(:weight)      { 10 }
    let(:params)      { { origin: origin, destination: destination, weight: weight } }

    before do
      allow_any_instance_of(Shipping).to receive(:cost).and_return(10)
    end

    it 'responds successfully' do
      get :show , params: params
      parsed = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(parsed['origin']).to eq origin
      expect(parsed['destination']).to eq destination
      expect(parsed['weight']).to eq weight
    end

    it 'responds with error' do
      get :show, params: {}

      expect(response).to have_http_status(:precondition_failed)
    end
  end
end
