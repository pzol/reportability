# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard 'bundler' do
  watch('Gemfile')
end

group :unit do
  guard 'rspec', :cli => "--color --format nested --fail-fast", :notification => true, :spec_paths => ['spec/lib'],
                 :run_all => { :cli => "--color --fail-fast" }, :turnip => true do
    watch(%r{^spec/lib/(.+)_spec\.rb$})
    watch(%r{^spec/lib/(.+)\.feature$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')  { "spec" }
  end
end

group :acceptance do
  guard 'rspec', :all_after_pass => false, :spec_paths => ["spec/acceptance"],
                 :run_all => { :cli => "-I spec/acceptance -r ./spec/acceptance/acceptance_helper.rb" }, :turnip => true,
                 :cli => "-I spec/acceptance --color --format nested --fail-fast -r ./spec/acceptance/acceptance_helper.rb", :notification => true do
    watch(%r{^spec/acceptance/.+_spec\.rb$})
    # Turnip features and steps
    watch(%r{^spec/acceptance/(.+)\.feature$})
    watch(%r{^spec/acceptance/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
  end
end

