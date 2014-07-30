require 'rails_helper'

RSpec.describe CitiesController, :type => :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  describe "GET /cities.json" do
    before do
      get :index, format: :json
    end

    context 'all cities' do 
      it 'returns all the cities' do 
        expect(json.collect { |l| l["name"] }).to include(City.first.name)
      end
    end 
  end

  describe 'GET /cities/:id.json' do 
    before do 
      get :show, format: :json, id: 1
    end

    context 'one city' do 
      it 'returns one city with all attributes' do 
        expect(json["id"]).to eq(City.first.id)
      end
    end

    context 'one city with its available listings' do 
      before do 
        get :show, format: :json, id: 1, start_date: '05-01-2014', end_date: '07-01-2014'
      end

      it 'returns one city with its available listings as a json attribute, given start and end dates as params' do 
        expect(json["city_openings"][0]["id"]).to eq(@listing1.id)
      end
    end

    context 'one city with its neighborhoods' do 
      before do
        get :show, format: :json, id: 1
      end
      
      it 'returns one city with its neighborhoods as a json attribute' do 
        expect(json["neighborhoods"].count).to eq(3)
      end
    end
  end

  describe 'GET /cities/most_res' do 
    xit 'returns city with the most reservations' do 
    end
  end

  describe 'GET /cities/highest_ratio_res_to_listings' do 
    xit 'returns city with highest ratio of reservations to listings' do 
    end
  end
end

