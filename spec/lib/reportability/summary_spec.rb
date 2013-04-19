require 'spec_helper'
require 'summary'

describe Reportability::Summary do
  it "description" do
    summary = Reportability::Summary.new(hierarchy=[:provider, :country, :tlc], always=[:currency, :date], values=[:count, :value])
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


