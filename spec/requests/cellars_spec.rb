require 'rails_helper'

RSpec.describe 'Cellar API', type: :request do
  # initialize test data 
  let!(:cellars) { create_list(:cellar, 10) }
  let(:cellar_id) { cellars.first.id }

  # Test suite for GET /cellars
  describe 'GET /cellars' do
    # make HTTP get request before each example
    before { get '/cellars' }

    it 'returns cellars' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /cellars/:id
  describe 'GET /cellars/:id' do
    before { get "/cellars/#{cellar_id}" }

    context 'when the record exists' do
      it 'returns the cellar' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(cellar_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:cellar_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cellar/)
      end
    end
  end

  # Test suite for POST /cellars
  describe 'POST /cellars' do
    # valid payload
    let(:valid_attributes) { { name: 'Luigi Bosca', location: 'somewhere in Argentina' } }

    context 'when the request is valid' do
      before { post '/cellars', params: valid_attributes }

      it 'creates a cellar' do
        expect(json['name']).to eq('Luigi Bosca')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/cellars', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Location can't be blank/)
      end
    end
  end

  # Test suite for PUT /cellars/:id
  describe 'PUT /cellars/:id' do
    let(:valid_attributes) { { name: 'Lopez' } }

    context 'when the record exists' do
      before { put "/cellars/#{cellar_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /cellars/:id
  describe 'DELETE /cellars/:id' do
    before { delete "/cellars/#{cellar_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end