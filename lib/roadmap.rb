module Roadmap
	def get_roadmap(roadmap_id)
		response = self.class.get(api_url("roadmaps/37"), headers: headers)

		@roadmap = JSON.parse(response.body)
	end

	def get_checkpoint(checkpoint_id)
		response = self.class.get(api_url("checkpoints/2553"), headers: headers)

		@checkpoint = JSON.parse(response.body)
	end
end