require "rails_helper"

RSpec.describe 'MapQuestFacade', :vcr do
  describe '#initialize' do
    it 'instance' do
      facade = MapquestFacade.new('Denver, Co')

      expect(facade).to be_an_instance_of(MapquestFacade)
    end
  end

  describe '#coordinates' do
    it 'get_coordinates'do
      facade = MapquestFacade.new('Denver,Co')

      coordinates = facade.coordinates

      expect(coordinates).to be_a(Hash)
      expect(coordinates[:lat]).to be_a(Float)
      expect(coordinates[:lng]).to be_a(Float)
    end
  end 
end
