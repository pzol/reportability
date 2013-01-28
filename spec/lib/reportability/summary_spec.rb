require 'spec_helper'

class Summary
  def initialize(level_fields, always_fields, value_fields, aggregates={})
    @level_fields  = level_fields
    @always_fields = always_fields
    @value_fields  = value_fields
    @levels        = {}
    @aggregates    = Hash.new(default_aggregate).merge(aggregates)
  end

  def push(row)
    @level_fields.each do |e|
      update_level(e, row)
    end
  end

  # flattens the output
  def summary
    @levels.map { |k, v| k.merge(v) }
  end

  def inspect
    @levels
  end

private
  def update_level(e, row)
    level_num    = @level_fields.index(e)
    key_fields   = @level_fields[0..level_num] + @always_fields
    keys         = row.select { |k| key_fields.include?(k) }
    level_key    = {_level: level_num + 1}.merge(keys)
    values       = row.select { |k| @value_fields.include?(k)}

    v = {level_key => values}

    @levels.merge!(v) do |key, oldval, newval|
      oldval.merge!(newval) { |k, x, y| @aggregates[k].(x, y)}
    end
  end

  def default_aggregate
    ->(x,y) { x + y}
  end

end

describe Summary do
  it "description" do
    summary = Summary.new(hierarchy=[:provider, :country, :tlc], always=[:currency, :date], values=[:count, :value])
    rows   = [{provider: 'HOTELBEDS', country: 'IT', tlc: 'ROM', currency: 'EUR', date: '2013-01', count: 1, value: 10.0},
              {provider: 'HOTELBEDS', country: 'IT', tlc: 'VCE', currency: 'EUR', date: '2013-01', count: 1, value: 10.0},
              {provider: 'HOTELBEDS', country: 'ES', tlc: 'MAD', currency: 'EUR', date: '2013-01', count: 1, value: 10.0},
              {provider: 'HOTELBEDS', country: 'ES', tlc: 'MAD', currency: 'EUR', date: '2012-12', count: 1, value: 10.0},
              {provider: 'GTA',       country: 'IT', tlc: 'ROM', currency: 'EUR', date: '2012-12', count: 1, value: 10.0}]

    rows.each do |row|
      summary.push(row)
    end
    expected = [
      { _level: 1, provider: 'HOTELBEDS', currency: 'EUR', date: '2013-01',                            count: 3, value: 30.0 },
      { _level: 2, provider: 'HOTELBEDS', currency: 'EUR', date: '2013-01', country: 'IT',             count: 2, value: 20.0 },
      { _level: 3, provider: 'HOTELBEDS', currency: 'EUR', date: '2013-01', country: 'IT', tlc: 'ROM', count: 1, value: 10.0 },
      { _level: 3, provider: 'HOTELBEDS', currency: 'EUR', date: '2013-01', country: 'IT', tlc: 'VCE', count: 1, value: 10.0 },
      { _level: 2, provider: 'HOTELBEDS', currency: 'EUR', date: '2013-01', country: 'ES',             count: 1, value: 10.0 },
      { _level: 3, provider: 'HOTELBEDS', currency: 'EUR', date: '2013-01', country: 'ES', tlc: 'MAD', count: 1, value: 10.0 },
      { _level: 1, provider: 'HOTELBEDS', currency: 'EUR', date: '2012-12',                            count: 1, value: 10.0 },
      { _level: 2, provider: 'HOTELBEDS', currency: 'EUR', date: '2012-12', country: 'ES',             count: 1, value: 10.0 },
      { _level: 3, provider: 'HOTELBEDS', currency: 'EUR', date: '2012-12', country: 'ES', tlc: 'MAD', count: 1, value: 10.0 },
      { _level: 1, provider: 'GTA',       currency: 'EUR', date: '2012-12',                            count: 1, value: 10.0 },
      { _level: 2, provider: 'GTA',       currency: 'EUR', date: '2012-12', country: 'IT',             count: 1, value: 10.0 },
      { _level: 3, provider: 'GTA',       currency: 'EUR', date: '2012-12', country: 'IT', tlc: 'ROM', count: 1, value: 10.0 }
    ]
    summary.summary.should == expected
  end
end


