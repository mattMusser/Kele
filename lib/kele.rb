require 'httparty'
require 'json'

class Kele
	include HTTParty

	def initialize(email, password)
		@auth_token = self.class.post(api_url, body: { email: email, password: password })
	end

	private

	def api_url
		"https://www.bloc.io/api/v1/sessions"
	end
end