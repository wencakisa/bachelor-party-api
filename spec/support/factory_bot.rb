require 'support/api_helper'
require 'support/auth_helper'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.include ApiHelper, AuthHelper, type: :controller
end
