require 'rails_helper'

RSpec.describe 'User', :vcr do
  before(:each) do
    @user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
  end

  describe '#us2' do
    it 'creates a user/ signs up for one' do
      post '/api/v1/users', params: @user.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(201)

      json = JSON.parse(response.body, symbolize_names:true)
      # require 'pry'; binding.pry
      expect(json).to be_a(Hash)

      data = json[:data]
      
      expect(data).to have_key(:id)
      expect(data[:id]).to be_a(String)
      expect(data[:id]).to eq('1')

      expect(data).to have_key(:type)
      expect(data[:type]).to be_a(String)
      expect(data[:type]).to eq('user')

      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to be_a(Hash)

      expect(data[:attributes][:email]).to be_a(String)
      expect(data[:attributes][:password_digest]).to be_a(String)
      expect(data[:attributes][:api_key]).to be_a(String)


    end

    it 'sad path' do 
      user2 = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password123"
      }
      post '/api/v1/users', params: user2.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to_not be_successful
      # require 'pry'; binding.pry
      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:errors)
      expect(json[:errors][:password_confirmation]).to be_a(Array)

      expect(json[:errors][:password_confirmation].first).to eq("doesn't match Password")
    end
  end
end