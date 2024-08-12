# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcomes' do
  describe 'GET /index' do
    subject(:welcome_response) do
      get '/'
      response
    end

    it 'returns http success' do
      expect(welcome_response).to have_http_status(:success)
    end
  end
end
