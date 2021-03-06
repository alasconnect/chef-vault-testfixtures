if ENV["COVERAGE"]
  require "simplecov"
  require "simplecov-console"
  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console,
  ]
  SimpleCov.start
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
end

# a helper to clear the context between examples
class ChefVault
  class TestFixtures
    class << self
      def clear_context
        @context = nil
      end
    end
  end
end
