RSpec.describe UsersController, :type => :controller do
  render_views

  describe 'GET /users' do 
    it 'returns all users' do
      get :index, format: :json
      body = JSON.parse(response.body)
      user_names = body.collect { |l| l["name"] }
      expect(response.status).to eq 200
      expect(user_names).to include(User.first.name)
    end

    it 'returns all users that are hosts' do
     get :index, format: :json, host: true.to_s
      body = JSON.parse(response.body)
      user_names = body.collect { |l| l["name"] }
      expect(response.status).to eq 200
      expect(user_names.count).to eq(3)
    end
  end

  describe 'GET /users/:id' do 
    it 'returns one user' do 
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      user_id = body["id"]
      user_name = body["name"]
      user_host = body["host"]
      expect(response.status).to eq 200
      expect(user_id).to eq(User.first.id)
      expect(user_name).to eq(User.first.name)
      expect(user_host).to eq(User.first.host)
    end

    it 'returns their listings as a json attribute' do 
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      first_listing = body["listings"][0]["address"]
      expect(response.status).to eq 200
      expect(first_listing).to eq(@listing1.address)
    end

    it 'returns their reservations as a json attribute' do
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      first_reservation = body["reservations"][0]["id"]
      expect(response.status).to eq 200
      expect(first_reservation).to eq(@reservation1.id)
    end 

    it 'returns their reservation count as a json attribute' do
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      res_count = body["res_count"]
      expect(response.status).to eq 200
      expect(res_count).to eq(User.first.reservations.count)
    end 

    it 'returns their trips as a json attribute' do 
      get :show, format: :json, id: 6
      body = JSON.parse(response.body)
      first_trip = body["trips"][0]["id"]
      expect(response.status).to eq 200
      expect(first_trip).to eq(@reservation3.id)
    end

    it 'if present, returns their hosts as a json attribute' do 
      get :show, format: :json, id: 6
      body = JSON.parse(response.body)
      first_host = body["hosts"][0]["name"]
      expect(response.status).to eq 200
      expect(first_host).to eq(@arel.name)
    end

    it 'if present, returns their guests as a json attribute' do 
      get :show, format: :json, id: 3
      body = JSON.parse(response.body)
      first_guest = body["guests"][0]["name"]
      expect(response.status).to eq 200
      expect(first_guest).to eq(@avi.name)
    end

    it 'if host, returns their reviews from guests' do 
      get :show, format: :json, id: 3
      body = JSON.parse(response.body)
      first_review = body["host_reviews"][0]["id"]
      expect(response.status).to eq 200
      expect(first_review).to eq(@review3.id)
    end

    it 'if host, returns their host_reviews count' do
      get :show, format: :json, id: 3
      body = JSON.parse(response.body)
      review_count = body["host_review_count"]
      expect(response.status).to eq 200
      expect(review_count).to eq(1)
    end
  end

end