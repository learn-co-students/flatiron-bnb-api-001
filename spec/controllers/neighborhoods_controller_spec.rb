require 'rails_helper'

RSpec.describe NeighborhoodsController, :type => :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  describe "GET /neighborhoods.json" do 
    before do
      get :index, format: :json
    end

    context 'all neighborhoods' do 
      it 'returns all the neighborhoods' do 
        expect(json.collect { |l| l["name"] }).to include(Neighborhood.first.name)
      end
    end
  end

  describe 'GET /neighborhoods/:id.json' do 
    before do
      get :show, format: :json, id: 1
    end

    context 'one listing' do 
      it 'returns one neighborhood with all attributes' do 
        expect(json["id"]).to eq(Neighborhood.first.id)
      end
    end

    context 'one listing with its available listings' do 
      before do 
        get :show, format: :json, id: 1, start_date: '05-01-2014', end_date: '07-01-2014'
      end
      it 'returns one neighborhood with its available listings as a json attribute, given start and end dates as params' do 
        expect(json["neighborhood_openings"][0]["id"]).to eq(@listing1.id)
      end
    end
  end
end

