require 'httparty'
require 'json'

class Kele
	include HTTParty

	def initialize(email, password)
		response = self.class.post(api_url, body: { email: email, password: password })

		if response.code == 200
			@auth_token = response["auth_token"]
		else
			p "Invalid Credentials -- You shall not pass!"
		end
	end

	private

	def api_url
		"https://www.bloc.io/api/v1/sessions"
	end
end