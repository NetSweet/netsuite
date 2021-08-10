RSpec::Matchers.define :have_search_only_field do |attribute|

  match do |model|
    expect(model.search_only_fields.include?(attribute)).to be_truthy
  end

end
