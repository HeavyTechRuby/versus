# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Competitions' do
  let!(:user) { User.create(id: 1, username: 'test') }

  let(:valid_attributes) do
    {
      name: 'valid name',
      description: 'some description',
      author_id: user.id
    }
  end

  let(:invalid_attributes) do
    {
      description: 'some description'
    }
  end

  describe 'GET /competitions' do
    subject(:competitions_response) do
      get '/competitions'
      response
    end

    before { Competition.create!(valid_attributes) }

    it 'renders a successful response' do
      expect(competitions_response).to have_http_status(:success)
    end
  end

  describe 'GET /competitions/:id' do
    subject(:competition_response) do
      get "/competitions/#{competition.id}"
      response
    end

    let!(:competition) { Competition.create!(valid_attributes) }

    it 'renders a successful response' do
      aggregate_failures do
        expect(competition_response).to have_http_status(:success)
        expect(competition_response.body).to include(competition.name)
      end
    end
  end

  describe 'POST /competitions' do
    subject(:create_competition_response) do
      post '/competitions/', params: request_params
      response
    end

    let(:request_params) { { competition: valid_attributes } }

    it 'creates a new Competition' do
      aggregate_failures do
        expect { create_competition_response }.to change(Competition, :count).by(1)
        expect(create_competition_response).to redirect_to('/competitions/1')
      end
    end

    context 'with invalid parameters' do
      let(:request_params) { { competition: invalid_attributes } }

      it 'does not create a new Competition' do
        aggregate_failures do
          expect { create_competition_response }.not_to change(Competition, :count)
          expect(create_competition_response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe 'PATCH /competitions/:id' do
    subject(:update_competition_response) do
      patch "/competitions/#{competition.id}", params: request_params
      response
    end

    let!(:competition) { Competition.create!(valid_attributes) }

    let(:request_params) do
      {
        competition: {
          name: 'new name'
        }
      }
    end

    it 'updates a Competition' do
      aggregate_failures do
        expect(update_competition_response).to redirect_to("/competitions/#{competition.id}")
        expect(competition.reload.name).to eq(request_params[:competition][:name])
      end
    end

    context 'with invalid parameters' do
      let(:request_params) do
        {
          competition: {
            name: ''
          }
        }
      end

      it 'does not update a Competition' do
        expect(update_competition_response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when competition has another author' do
      before do
        new_author = User.create(username: 'NewAuthor')
        competition.update(author_id: new_author.id)
      end

      it 'redirect to root path' do
        expect(update_competition_response).to redirect_to(root_path)
      end
    end
  end
end
