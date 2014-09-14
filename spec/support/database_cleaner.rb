RSpec.configure do |config|
  # Don't use transactional fixtures, because Capybara tests that use
  # JavaScript run in a different process, so the process running the
  # app won't have the db records created in the test process.
  config.use_transactional_fixtures = false

  # Instead of transactional fixtures, we use DatabaseCleaner to clean
  # the DB between specs. We use the transaction strategy because it's
  # the fastest.
  config.before :each do
    DatabaseCleaner.strategy = :transaction
  end

  # Switch to the truncation strategy for javascript tests, for the same
  # reason we don't use transaction fixtures above, but *only clean used
  # tables*
  config.before :each, :js => true do
    DatabaseCleaner.strategy = :truncation, {:pre_count => true}
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
