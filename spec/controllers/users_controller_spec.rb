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

    xit 'returns their listings as a json attribute' do 
    end

    xit 'returns their reservations as a json attribute' do
    end 

    xit 'returns their reservation count as a json attribute' do
    end 

    xit 'returns their trips as a json attribute' do 
    end

    xit 'if present, returns their hosts as a json attribute' do 
    end

    xit 'if present, returns their guests as a json attribute' do 
    end

    xit 'if host, returns their reviews from guests' do 
    end

    xit 'if host, returns their host_reviews count' do
    end
  end

end