RSpec.configure do |config|
  config.include(FunctionalOperations::DSL, type: :operation)
end
