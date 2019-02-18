require 'rails_helper'

RSpec.describe 'Wines API' do
  # Initialize the test data
  let!(:cellar) { create(:cellar) }
  let!(:wines) { create_list(:wine, 20, cellar_id: cellar.id) }
  let(:cellar_id) { cellar.id }
  let(:id) { wines.first.id }

  # Test suite for GET /cellars/:cellar_id/wines
  describe 'GET /cellars/:cellar_id/wines' do
    before { get "/cellars/#{cellar_id}/wines" }

    context 'when cellar exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all cellar wines' do
        expect(json.size).to eq(20)
      end
    end

    context 'when cellar does not exist' do
      let(:cellar_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cellar/)
      end
    end
  end

  # Test suite for GET /cellars/:cellar_id/wines/:id
  describe 'GET /cellars/:cellar_id/wines/:id' do
    before { get "/cellars/#{cellar_id}/wines/#{id}" }

    context 'when cellar wine exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the wine' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when cellar wine does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Wine/)
      end
    end
  end

  # Test suite for PUT /cellars/:cellar_id/wines
  describe 'POST /cellars/:cellar_id/wines' do
    let(:valid_attributes) { { name: 'La Linda', harvest: 2016, strain: 'Malbec' } }

    context 'when request attributes are valid' do
      before { post "/cellars/#{cellar_id}/wines", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/cellars/#{cellar_id}/wines", params: {harvest: 2015, strain: 'Malbec' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /cellars/:cellar_id/wines/:id
  describe 'PUT /cellars/:cellar_id/wines/:id' do
    let(:valid_attributes) { { name: 'Luigi Bosca' } }

    before { put "/cellars/#{cellar_id}/wines/#{id}", params: valid_attributes }

    context 'when wine exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the wine' do
        updated_wine = Wine.find(id)
        expect(updated_wine.name).to match(/Luigi Bosca/)
      end
    end

    context 'when the wine does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Wine/)
      end
    end
  end

  # Test suite for DELETE /cellars/:id
  describe 'DELETE /cellars/:id' do
    before { delete "/cellars/#{cellar_id}/wines/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end