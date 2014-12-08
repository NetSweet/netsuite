RSpec::Matchers.define :have_read_only_field do |attribute|

  match do |model|
    expect(model.read_only_fields.include?(attribute)).to be_truthy
  end

end
