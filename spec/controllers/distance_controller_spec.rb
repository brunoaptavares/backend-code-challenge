require 'rails_helper'

RSpec.describe DistanceController, type: :controller do

  describe 'POST create' do
    let(:instance) { described_class.new }
    let(:point_a)  { 'A' }
    let(:point_b)  { 'B' }
    let(:distance) { 10 }
    let(:params)   { { point_a: point_a, point_b: point_b, distance: distance } }

    it 'responds successfully' do
      post :create , params: params
      parsed = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response).to have_http_status(:created)
      expect(parsed['point_a']).to eq point_a
      expect(parsed['point_b']).to eq point_b
      expect(parsed['distance']).to eq distance
    end

    it 'responds with error' do
      post :create, params: {}

      expect(response).to have_http_status(:precondition_failed)
    end
  end
end
