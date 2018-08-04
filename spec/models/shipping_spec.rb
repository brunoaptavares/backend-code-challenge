require 'rails_helper'

RSpec.describe Shipping do
  describe 'ActiveRecord specification' do
    it { is_expected.to validate_presence_of(:origin) }
    it { is_expected.to validate_presence_of(:destination) }
    it { is_expected.to validate_presence_of(:weight) }
  end

  describe '#initialize' do
    let(:attrs) do
      {
        origin:      'A',
        destination: 'B',
        weight:      10
      }
    end

    subject { described_class.new(attrs) }

    its(:origin)      { is_expected.to eq 'A' }
    its(:destination) { is_expected.to eq 'B' }
    its(:weight)      { is_expected.to eq 10 }
  end

  context 'validation' do
    let(:s) { build(:shipping) }

    context 'with a weight less than the minimum' do
      let(:s) { build(:shipping, weight: -1) }

      subject { s.valid? }

      it { is_expected.to be_falsey }
    end

    context 'with a weight greater than the maximum' do
      let(:s) { build(:shipping, weight: 51) }

      subject { s.valid? }

      it { is_expected.to be_falsey }
    end

    context 'with a valid shipping' do
      subject { s.valid? }

      it { is_expected.to be_truthy }
    end
  end

  describe '#cost' do
    let(:s) { build(:shipping, origin: 'A', destination: 'C', weight: 10) }

    subject { s.cost }

    context 'when cost is calculated' do
      before do
        create(:distance, point_a: 'A', point_b: 'B', distance: 10)
        create(:distance, point_a: 'A', point_b: 'C', distance: 30)
        create(:distance, point_a: 'B', point_b: 'C', distance: 15)
      end

      it { is_expected.to be(25 * s.weight * 0.15) }
    end

    context 'when cost is not calculated' do
      specify { expect { subject }.to raise_error(Shipping::PathNotFoundError) }
    end
  end
end
