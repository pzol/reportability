require 'bundler/setup'
require 'turnip/rspec'
require 'reportability'

Dir.glob("spec/lib/**/*_steps.rb") { |f| load f, true }

$LOAD_PATH << File.expand_path('../../lib', __FILE__) # the gem's lib dir
