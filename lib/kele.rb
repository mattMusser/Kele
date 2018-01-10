require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
	include HTTParty
	include Roadmap

	def initialize(email, password)
		response = self.class.post(api_url("sessions"), body: { email: email, password: password })

		if response.code == 200
			@auth_token = response["auth_token"]
			p "You shall pass!"
		else
			p "Invalid Credentials -- You shall not pass!"
		end
	end

	def get_me
		response = self.class.get(api_url("users/me"), headers: { "authorization" => @auth_token })

		@user = JSON.parse(response.body)
	end

	def get_mentor_availability(mentor_id)
		response = self.class.get(api_url("mentors/2367142/student_availability"), headers: { "authorization" => @auth_token })

		@availability = JSON.parse(response.body)
	end

	def get_messages(page = 'all')
		get_message = page == 'all' ? ("/message_threads?page#{page}") : get_message = "/message_threads"

		response = self.class.get(api_url(get_message), headers: { "authorization" => @auth_token })

		@messages = JSON.parse(response.body)
	end

	def create_message(sender_email, recipient_id, message_body, subject)
		response = self.class.post(api_url("messages"), headers: { "authorization" => @auth_token }, body: { sender: sender_email, recipient_id: recipient_id, stripped_text: message_body, subject: subject })

		puts "Your message has been sent!" if response.success?
	end

	def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
		response = self.class.post(api_url("checkpoint_submissions"), headers: headers, body: { checkpoint_id: checkpoint_id, assignment_branch: assignment_branch, assignment_commit_link: assignment_commit_link, comment: comment, enrollment_id: enrollment_id })

		puts "Checkpoint has been submitted" if response.success?
	end

	private

	def api_url(endpoint)
		"https://www.bloc.io/api/v1/#{ endpoint }"
	end

	def headers
		headers = { "authorization" => @auth_token }
	end
end