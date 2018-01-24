class Mutations::DeleteAuthor < GraphQL::Function

	argument :id, types.ID


	type types.Boolean


    def call(obj, args, ctx)
    	author = Author.find(args[:id])
    	!!author.destroy
    end


  end