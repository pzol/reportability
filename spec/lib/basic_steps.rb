require 'multi_json'

step 'I load :name' do |name|
  filename = File.expand_path("../#{name}.json", __FILE__)
  json     = IO.read(filename)
  @input   = MultiJson.load(json)
end

step 'the json' do |json|
  @input = MultiJson.load(json)
end

step 'I pivot it' do
  r = Reportability::Pivot.new
  @output = r.call [:c, :r, :v], @input
end

require 'active_support/core_ext/hash/slice'
step 'I magic-pivot it2' do
  r = Reportability::Pivot.new
  r.project do |row|
    [
      row["date"],
      row.slice("_level", "provider", "currency", "country", "tlc"),
      row.slice("count", "value")
    ]
  end
  @output = r.call [:date_booked, :date, :values], @input
end

step 'I magic-pivot it' do
  r = Reportability::Pivot.new
  r.project do |row|
    key = row['key']
    [
      "%4d-%02d" % [key['date_from']['y'], key['date_from']['m']],
      [key['provider'], key['tlc']].join(', '),
      row['value']['count']
    ]
  end
  @output = r.call [:date_booked, :provider_tlc, :count], @input
end

step 'the output is' do |expected_result|
  @output.inspect.should == expected_result
end

step 'the result table is' do |table|
  @output.rows.each_index do |i|
    expected_row = table.raw[i] || []
    expected = expected_row.join(' | ')
    actual   = @output.rows[i].join(' | ')
    actual.should == expected
  end
end
