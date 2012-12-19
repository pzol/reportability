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
    r.project do |row|
      key = row['_id']
      [
        "%4d-%02d" % [key['date_booked']['y'], key['date_booked']['m']],
        [key['provider'], key['tlc']],
        row['count']
      ]
    end
    @output = r.call [:date_booked, :provider_tlc, :count], @input
end

step 'the output is' do |expected_result|
  @output.inspect.should == expected_result
end
