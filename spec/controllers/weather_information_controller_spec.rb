require 'rails_helper'

RSpec.describe WeatherInformationController, type: :controller do
	describe '#index' do
		it 'returns 200 status' do
			get :index

			expect(response.status).to be 200
		end
	end

	describe '#data' do
		it 'returns 200 status' do
			post :data, params: { location: "Goa, India", location_latitude: "15.2993265", location_longitude: "74.12399599999999" }

			expect(response.status).to be 200
		end
	end
end
