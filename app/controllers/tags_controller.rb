class TagsController < ApplicationController

	def index
		@tags = ["c#", "visual studio", "maths", "geometry", "chemistry", "analytic algebra", "jquery", "json", "ajax"]
	end
	
end
