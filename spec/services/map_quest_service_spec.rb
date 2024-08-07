require 'rails_helper'

RSpec.describe 'Mapquest Service', :vcr do

  describe '#get_coordinates' do
    it 'get the coordinates of the location' do
      coords = MapQuestService.new.get_coordinates('Denver, Co')

      expect(coords).to be_a(Hash)

      expect(coords).to have_key(:results)
      expect(coords[:results]).to be_a(Array)
      
      expect(coords[:results].first).to be_a(Hash)
      expect(coords[:results].first).to have_key(:locations)
      
      expect(coords[:results].first[:locations]).to be_a(Array)
      
      expect(coords[:results].first[:locations].first).to have_key(:latLng)

      expect(coords[:results].first[:locations].first[:latLng]).to be_a(Hash)
      expect(coords[:results].first[:locations].first[:latLng][:lat]).to eq(39.74001)
      expect(coords[:results].first[:locations].first[:latLng][:lng]).to eq(-104.99202)

    end
  end

  describe '#get_travel_route' do
    it 'gets to one place to the next' do
      travel = MapQuestService.new.get_travel_route("Denver, Co", "New York, NY")

      expect(travel).to be_a(Hash)
      # require 'pry'; binding.pry
      expect(travel).to have_key(:route)
      expect(travel[:route]).to be_a(Hash)
      expect(travel[:route]).to have_key(:formattedTime)

      # require 'pry'; binding.pry
      time = travel[:route][:formattedTime]
      expect(travel[:route][:formattedTime]).to eq("#{time}")
      expect(travel[:route][:formattedTime]).to be_a(String)

    end
  end
end