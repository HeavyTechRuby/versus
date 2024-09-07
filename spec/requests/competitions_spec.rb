# frozen_string_literal: true

RSpec.describe 'Competitions' do
  let(:valid_attributes) { attributes_for(:competition, author: user) }

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

    before do
      user = create(:user)
      create(:competition, author: user)
    end

    it 'renders a successful response' do
      expect(competitions_response).to have_http_status(:success)
    end
  end

  describe 'GET /competitions/:id' do
    subject(:competition_response) do
      get "/competitions/#{competition.id}"
      response
    end

    let!(:competition) { create(:competition, author: user) }
    let!(:user) { create(:user) }

    it 'renders a successful response' do
      aggregate_failures do
        expect(competition_response).to have_http_status(:success)
        expect(competition_response.body).to include(competition.name)
      end
    end
  end

  describe 'POST /competitions', :requires_auth, :with_auth do
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

    it_behaves_like 'with GitHub authentication'

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

  describe 'PATCH /competitions/:id', :requires_auth, :with_auth do
    subject(:update_competition_response) do
      patch "/competitions/#{competition.id}", params: request_params
      response
    end

    let(:competition) { create(:competition, author: user) }

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

    it_behaves_like 'with GitHub authentication'

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

    it_behaves_like 'without access to resource' do
      let(:competition) { create(:competition, author: another_user) }
    end
  end
end
