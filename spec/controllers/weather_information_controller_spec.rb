require 'rails_helper'

RSpec.describe WeatherInformationController, type: :controller do
	describe '#index' do
		it 'returns 200 status' do
			get :index

			expect(response.status).to be 200
		end
	end
end