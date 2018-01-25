class Mutations::CreateAuthor < GraphQL::Function
    description "Name of a writer"
	argument :author, Types::AuthorInputType

	type Types::AuthorType


    def call(obj, args, ctx)
    	is_public true
    	
    	Author.create args[:author].to_h
    end


  end