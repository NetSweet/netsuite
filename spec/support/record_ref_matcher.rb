RSpec::Matchers.define :have_record_ref do |attribute|

  match do |model|
    record_ref_can_be_set_and_retrieved?(model, attribute) && record_ref_can_be_set_on_instantiation?(model, attribute)
  end

  def record_ref_can_be_set_and_retrieved?(model, attribute)
    model.send("#{attribute}=".to_sym, attributes)
    expect(model.send(attribute)).to be_kind_of(NetSuite::Records::RecordRef)
  end

  def record_ref_can_be_set_on_instantiation?(model, attribute)
    new_model = model.class.new(attribute => attributes)
    expect(new_model.send(attribute)).to be_kind_of(NetSuite::Records::RecordRef)
  end

  def attributes
    {
      :@internal_id           => '125',
      :"@xmlns:platform_core" => 'urn:core_2011_2.platform.webservices.netsuite.com',
      :name                   => 'RP RecordRef'
    }
  end

end
