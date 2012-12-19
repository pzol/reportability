require 'bundler/setup'
Bundler.require :spec_unit
require 'reportability'

Dir.glob("spec/lib/**/*_steps.rb") { |f| load f, true }

$LOAD_PATH << File.expand_path('../../lib', __FILE__) # the gem's lib dir
