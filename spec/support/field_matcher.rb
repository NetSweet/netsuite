RSpec::Matchers.define :have_field do |attribute, klass|

  match do |model|
    klass = klass || Object

    field_can_be_set_and_retrieved?(model, attribute, klass) && field_can_be_set_on_instantiation?(model, attribute, klass)
  end

  def field_can_be_set_and_retrieved?(model, attribute, klass)
    obj = klass.new
    model.send("#{attribute}=".to_sym, obj)
    model.send(attribute) == obj
  end

  def field_can_be_set_on_instantiation?(model, attribute, klass)
    obj = klass.new
    new_model = model.class.new(attribute => obj)
    new_model.send(attribute) == obj
  end

end
