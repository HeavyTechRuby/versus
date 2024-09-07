# frozen_string_literal: true

RSpec.describe Users::OmniauthCallbacksController do
  describe 'routing' do
    it 'routes #github' do
      expect(post: '/users/auth/github/callback').to route_to('users/omniauth_callbacks#github')
    end
  end
end
