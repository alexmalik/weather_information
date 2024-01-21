require 'rails_helper'
require 'webmock/rspec'

RSpec.describe OpenWeatherService, type: :model do
	subject(:open_weather_service) { described_class.call(params[:location_latitude], params[:location_longitude]) }

	let(:open_weather_key) { Rails.application.credentials.open_weather_key }
	let(:params) do
		{
			location_latitude: "42.920232", 
			location_longitude: "-78.851731" 
		}
	end

	let(:request_headers) do
		{
			'Accept'=>'*/*',
	 	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
	 	  'User-Agent'=>'Ruby'
		}
	end

	let(:uri) do
		"https://api.openweathermap.org/data/2.5/weather?"\
		"appid=#{open_weather_key}&lat=#{params[:location_latitude]}&lon=#{params[:location_longitude]}"
	end

	let(:response_body) { File.open('spec/fixtures/open_weather_response_body.json') }

	before do
		stub_request(:get, uri)
		.with(headers: request_headers)
		.to_return(status: 200, body: response_body, headers: {})
	end

	it 'returns status 200' do
		expect(open_weather_service['cod']).to be 200
		expect(WebMock).to have_requested(:get, uri).with(headers: request_headers).at_least_once
	end

	it 'returns weather information about the provided location' do
		expect(open_weather_service['weather'][0]['main']).to eq 'Snow'
		expect(open_weather_service['weather'][0]['description']).to eq 'light snow'
		expect(open_weather_service['name']).to eq 'Buffalo'
		expect(WebMock).to have_requested(:get, uri).with(headers: request_headers).at_least_once
	end
end
