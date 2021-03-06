require 'spec_helper'

describe Fias::Query::Params do
  YAML.load_file('spec/fixtures/query_sanitization.yml').each do |pair|
    from, to = pair
    from.symbolize_keys!
    to.symbolize_keys!

    it from.values.to_s do
      expect(described_class.new(from).sanitized).to eq(to)
    end
  end

  it 'must not resanitize already sanitized parts' do
    sanitized = described_class.new(
      city: 'г Краснодар', street: 'Ушинского'
    ).sanitized

    expect(described_class.new(sanitized).sanitized).to eq(sanitized)
  end
end
