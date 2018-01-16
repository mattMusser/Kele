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

	def get_me
		response = self.class.get(me_url, headers: { "authorization" => @auth_token })
		JSON.parse(response.body)
	end

	def get_mentor_availability(mentor_id)
		response = self.class.get(mentor_url("#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
		JSON.parse(response.body)git
	end

	private

	def api_url
		"https://www.bloc.io/api/v1/sessions"
	end

	def me_url
		"https://www.bloc.io/api/v1/users/me"
	end

	def mentor_url(endpoint)
		"https://www.bloc.io/api/v1/mentors/#{endpoint}"
	end
end