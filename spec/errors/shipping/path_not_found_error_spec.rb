require 'rails_helper'

RSpec.describe Shipping::PathNotFoundError do

  describe '#initialize' do

    context 'with default message' do
      subject { described_class.new }

      its(:message) { is_expected.to eq 'Path not found' }
    end

    context 'with custom message' do
      let(:msg) { 'Custom message' }

      subject { described_class.new(msg) }

      its(:message) { is_expected.to eq 'Custom message' }
    end
  end
end
