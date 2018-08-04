require 'rails_helper'

RSpec.describe Distance, type: :model do
  describe 'ActiveRecord specification' do
    it { is_expected.to validate_presence_of(:point_a) }
    it { is_expected.to validate_presence_of(:point_b) }
    it { is_expected.to validate_presence_of(:distance) }

    it { is_expected.to have_db_column(:point_a).of_type(:string) }
    it { is_expected.to have_db_column(:point_b).of_type(:string) }
    it { is_expected.to have_db_column(:distance).of_type(:integer) }
  end

  describe '#initialize' do
    let(:params) do
      {
        point_a:  'A',
        point_b:  'B',
        distance: 100
      }
    end

    subject { described_class.new(params) }

    its(:point_a)  { is_expected.to eq 'A' }
    its(:point_b)  { is_expected.to eq 'B' }
    its(:distance) { is_expected.to eq 100 }
  end

  context 'validation' do
    let(:d) { build(:distance) }

    context 'with a distance less than the minimum' do
      let(:d) { build(:distance, distance: -1) }

      subject { d.valid? }

      it { is_expected.to be_falsey }
    end

    context 'with a distance greater than the maximum' do
      let(:d) { build(:distance, distance: 100001) }

      subject { d.valid? }

      it { is_expected.to be_falsey }
    end

    context 'with a valid distance' do
      subject { d.valid? }

      it { is_expected.to be_truthy }
    end
  end
end
