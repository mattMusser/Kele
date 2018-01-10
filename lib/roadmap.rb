module Roadmap
	def get_roadmap(roadmap_id)
		response = self.class.get(api_url("roadmaps/37"), headers: { "authorization" => @auth_token })

		@roadmap = JSON.parse(response.body)
	end

	def get_checkpoint(checkpoint_id)
		response = self.class.get(api_url("checkpoints/157"), headers: { "authorization" => @auth_token })

		@checkpoint = JSON.parse(response.body)
	end
end