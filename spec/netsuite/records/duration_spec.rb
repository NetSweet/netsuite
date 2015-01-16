require 'spec_helper'

describe NetSuite::Records::Duration do
  let(:duration) { NetSuite::Records::Duration.new }

  it 'has all the right fields' do
    [
      :time_span, :unit
    ].each do |field|
      expect(duration).to have_field(field)
    end
  end

end
