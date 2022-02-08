require 'spec_helper'

describe NetSuite::Records::Translation do
  # let(:translation) { NetSuite::Records::Translation.new(field_one: 'value one', field_two: 'value two', field_three: 'value three') }

  it 'has dynamic fields' do
    translation = NetSuite::Records::Translation.new(field_one: 'value one', field_two: 'value two', field_three: 'value three')
    [
      :field_one,
      :field_two,
      :field_three
    ].each do |field|
      expect(translation).to have_field(field)
    end
  end
end