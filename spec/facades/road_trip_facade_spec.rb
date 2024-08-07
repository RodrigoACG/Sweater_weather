require "rails_helper"

RSpec.describe 'RoadTripFacade', :vcr do
  describe '#initialize' do
    it 'creates a RoadTripFacade object' do
      facade = RoadTripFacade.new("New York, NY", "Los Angeles, CA")

      expect(facade).to be_an_instance_of(RoadTripFacade)
    end
  end

  describe '#travel' do
    it 'get_travel_route' do
      facade = RoadTripFacade.new("New York, NY", "Los Angeles, CA")

      travel_info = facade.travel_info

      expect(travel_info).to be_a(Hash)
      expect(travel_info[:start_city]).to eq("New York, NY")
      expect(travel_info[:end_city]).to eq("Los Angeles, CA")
      expect(travel_info[:travel_time]).to be_a(String)
    end

    it 'gets impossible route information if route is impossible' do
      facade = RoadTripFacade.new("New York, NY", "London, UK")

      travel_info = facade.travel_info

      expect(travel_info).to be_a(Hash)
      expect(travel_info[:start_city]).to eq("New York, NY")
      expect(travel_info[:end_city]).to eq("London, UK")
      expect(travel_info[:travel_time]).to eq("impossible")
    end
  end
end
