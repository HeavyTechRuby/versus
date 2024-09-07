# frozen_string_literal: true

Before('@omniauth_test') do
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:github, Faker::Omniauth.github)
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end
