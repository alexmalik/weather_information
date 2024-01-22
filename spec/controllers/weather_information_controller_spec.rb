require 'rails_helper'

RSpec.describe WeatherInformationController, type: :controller do
	render_views
	describe '#index' do
		it 'returns 200 status' do
			get :index

			expect(response.status).to be 200
		end
	end

	describe '#data' do
		context 'with location params' do
			subject { post :data, params: form_params, as: :turbo_stream }
			let(:open_weather_key) { Rails.application.credentials.open_weather_key }

			let(:uri) do
				"https://api.openweathermap.org/data/2.5/weather?" \
				"appid=#{open_weather_key}&lat=#{form_params[:latitude]}&lon=#{form_params[:longitude]}"
			end

			let(:request_headers) do
				{
					'Accept'=>'*/*',
					'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
					'User-Agent'=>'Ruby'
				}
			end

			let(:form_params) do
				{
					location: "Goa, India", 
					latitude: "15.2993265", 
					longitude: "74.12399599999999"
				}
			end

			let(:response_headers) { { 'content-type': 'text/vnd.turbo-stream.html' } }
			let(:open_weather_response) { File.open('spec/fixtures/open_weather_response_body.json') }

			before do
				stub_request(:get, uri)
				.with(headers: request_headers)
        .to_return(status: 200, headers: response_headers, body: open_weather_response)
        subject
			end

			it 'returns 200 status' do
				expect(response.status).to be 200
				expect(WebMock).to have_requested(:get, uri).with(headers: request_headers).at_least_once
			end

			it 'returns a template with matching id' do
				expect(response.body).to match(/<div id=\"weather_info\">/)
				expect(WebMock).to have_requested(:get, uri).with(headers: request_headers).at_least_once
			end
		end
	end
end
