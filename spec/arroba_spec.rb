# frozen_string_literal: true

RSpec.describe Arroba do
  describe 'VERSION' do
    subject { Arroba::VERSION }

    it { is_expected.not_to be_nil }
    it { is_expected.to be_a(String) }
  end
end
