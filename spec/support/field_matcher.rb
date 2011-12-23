RSpec::Matchers.define :have_field do |attribute|

  match do |model|
    field_can_be_set_and_retrieved?(model, attribute) && field_can_be_set_on_instantiation?(model, attribute)
  end

  def field_can_be_set_and_retrieved?(model, attribute)
    obj = Object.new
    model.send("#{attribute}=".to_sym, obj)
    model.send(attribute) == obj
  end

  def field_can_be_set_on_instantiation?(model, attribute)
    obj = Object.new
    new_model = model.class.new(attribute => obj)
    new_model.send(attribute) == obj
  end

end
