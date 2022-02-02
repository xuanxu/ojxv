# frozen_string_literal: true

require 'rake/testtask'

task :default => :spec

Rake::TestTask.new(:spec) do |t|
  t.description = "Run specs for OJXV"
  t.test_files = Dir.glob('spec/lib/**/*_spec.rb')
  t.libs << "spec"
end
