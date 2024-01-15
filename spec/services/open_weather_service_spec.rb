require 'rails_helper'
require 'webmock/rspec'

RSpec.describe OpenWeatherService, type: :model do
	subject { described_class.call(params[:location_latitude], params[:location_longitude]) }

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

	it 'returns weather information about the provided location' do
		stub_request(:get, uri)
		.with(headers: request_headers)
		.to_return(status: 200, body: response_body, headers: {})

		expect(subject['cod']).to be 200
		expect(subject['weather'][0]['main']).to eq 'Snow'
		expect(subject['weather'][0]['description']).to eq 'light snow'
	end
end
