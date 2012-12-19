require 'rspec/core/rake_task'

SPEC_SUITES = [
  { :id => :unit,
    :title => 'unit',
    :files => %w(spec/lib/**/*_spec.rb spec/lib/**/*.feature) },
  { :id => :acceptance,
    :title => 'acceptance',
    :files => %w(spec/acceptance/**/*.feature spec/acceptance/**/*_spec.rb),
    :opts => '-I spec/acceptance -r ./spec/acceptance/acceptance_helper.rb' },
]


namespace :spec do
  SPEC_SUITES.each do |suite|
    desc "Run #{suite[:title]} tests"
    RSpec::Core::RakeTask.new(suite[:id]) do |t|
      spec_files = []
      suite[:files].each { |glob| spec_files += Dir[glob] } if suite[:files]
      t.pattern = spec_files

      t.rspec_opts = suite[:opts] if suite.has_key? :opts
    end
  end
end
