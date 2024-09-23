# frozen_string_literal: true

shared_context 'with authentication' do
  let(:user) { create(:user) }

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end
end

shared_examples 'with GitHub authentication', :with_github_auth do
  context 'when authenticated with Github' do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(:github,
                               OmniAuth::AuthHash.new(JSON.parse(read_fixture_file('omniauth/github.json'))))
      Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
      post user_github_omniauth_callback_path
      follow_redirect!
    end

    after do
      OmniAuth.config.test_mode = false
      Rails.application.env_config['omniauth.auth'] = nil
    end

    it 'successfully authenticated' do
      expect(response).to have_http_status(:success)
    end
  end
end

shared_examples 'requires authentication', :requires_auth do
  let(:user) { {} }

  it 'returns error' do
    expect(response).to have_http_status(:unauthorized)
  end
end

shared_examples 'without access to resource', :without_access_to_resource do
  context 'when try to access to resource belongs to another user' do
    let(:another_user) { create(:user, email: 'another_test@test.com') }
    let(:path) { root_path }

    it 'returns error' do
      expect(subject).to redirect_to(root_path)
    end
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'with authentication', :with_auth, type: :request
end
