require 'helpers/api_helper'
require 'helpers/auth_helper'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.include ApiHelper, AuthHelper, type: :controller
end
