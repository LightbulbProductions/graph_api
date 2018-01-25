class Mutations::UpdateAuthor < GraphQL::Function
    description "Update Author by their ID"
    argument :id, types.ID
    argument :author, Types::AuthorInputType
    
    type Types::AuthorType

    def call(obj, args, ctx)
    	is_public true

    	author = Author.find(args[:id])
    	author.try :update, args[:author].to_h
    	author
    end

end
