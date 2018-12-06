require "bundler/setup"
require "hamdown"
Dir["lib/hamdown/*.rb"].each do |f|
  require_relative "../#{f}"
end
require 'pry'
require 'shared/text_stuff'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include_context "text stuff", :include_shared => true
end
