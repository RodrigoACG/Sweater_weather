require 'rails_helper'

RSpec.describe 'Sessions', :vcr do
  before(:each) do
    @user = User.create!(email: "whatever@example.com", password: 'password', password_confirmation: 'password')
  end

  describe '#us 3' do
    it 'log into the app and create a session' do
      user = {
        "email": "whatever@example.com",
        "password": "password"
        
      }

      post '/api/v1/sessions', params: user.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
     
      expect(response).to be_successful
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry

      expect(json).to be_a(Hash)
      expect(json).to have_key(:data)

      expect(json[:data]).to be_a(Hash)

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_a(String)
      expect(json[:data][:id]).to eq('1')

      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to be_a(String)
      expect(json[:data][:type]).to eq('user')

      expect(json[:data]).to have_key(:attributes)

      expect(json[:data][:attributes]).to be_a(Hash)

      expect(json[:data][:attributes]).to have_key(:email)
      expect(json[:data][:attributes][:email]).to be_a(String)
      expect(json[:data][:attributes][:email]).to eq('whatever@example.com')
      
      expect(json[:data][:attributes]).to have_key(:password_digest)
      expect(json[:data][:attributes][:password_digest]).to be_a(String)

      expect(json[:data][:attributes]).to have_key(:api_key)
      expect(json[:data][:attributes][:api_key]).to be_a(String)
    end

    it 'sad path' do 
      user = {
        "email": "whatever@example.com",
        "password": "wrong"
        
      }

      post '/api/v1/sessions', params: user.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
     
      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      json = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry

      expect(json).to be_a(Hash)
      expect(json).to have_key(:errors)

      expect(json[:errors]).to be_a(String)
      expect(json[:errors]).to eq("Email or Passowrd is incorrect, Please Try Again!")
    end
  end
end


