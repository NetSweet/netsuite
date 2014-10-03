RSpec::Matchers.define :have_read_only_field do |attribute|

  match do |model|
    model.read_only_fields.include?(attribute).should be_truthy
  end

end
