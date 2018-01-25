class Author < ApplicationRecord
	validates :last_name, presence: true
	
	
	def coordinates
		[rand(50), rand(90)]
	end
end
