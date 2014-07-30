require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  describe 'GET /users.json' do 
    before do 
      get :index, format: :json
    end

    context 'all users' do 
      it 'returns all users' do
        expect(json.collect { |l| l["name"] }).to include(User.first.name)
      end
    end

    context 'all users that are hosts' do 
      before do 
        get :index, format: :json, host: true.to_s
      end

      it 'returns all users that are hosts' do
        expect(json.collect { |l| l["name"] }.count).to eq(3)
      end
    end
  end

  describe 'GET /users/:id.json' do 
    context 'user 1' do 
      before do 
        get :show, format: :json, id: 1
      end

      it 'returns one user' do 
        expect(json["id"]).to eq(User.first.id)
      end

      it 'returns their listings as a json attribute' do 
        expect(json["listings"][0]["address"]).to eq(@listing1.address)
      end

      it 'returns their reservations as a json attribute' do
        expect(json["reservations"][0]["id"]).to eq(@reservation1.id)
      end 

      it 'returns their reservation count as a json attribute' do
        expect(json["res_count"]).to eq(User.first.reservations.count)
      end 
    end

    context 'guest user' do 
      before do 
        get :show, format: :json, id: 6
      end

      it 'returns their trips as a json attribute' do 
        expect(json["trips"][0]["id"]).to eq(@reservation3.id)
      end

      it 'if present, returns their hosts as a json attribute' do 
        expect(json["hosts"][0]["name"]).to eq(@arel.name)
      end
    end
    context 'host user' do 
      before do
        get :show, format: :json, id: 3
      end

      it 'if present, returns their guests as a json attribute' do 
        expect(json["guests"][0]["name"]).to eq(@avi.name)
      end

      it 'if host, returns their reviews from guests' do
        expect(json["host_reviews"][0]["id"]).to eq(@review3.id)
      end

      it 'if host, returns their host_reviews count' do
        expect(json["host_review_count"]).to eq(1)
      end
    end
  end

end