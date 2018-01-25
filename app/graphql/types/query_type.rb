Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
   description "this needs a description"

   field :testField, types.String do
    # Arguments are passed from the front to the back.
    argument :name, types.String, "Enter your name here"
    description "An example field added by the generator"
    is_public true

    resolve ->(obj, args, ctx) {
      # A way to log into the server terminal
      # Rails.logger.info ctx.query
      # Rails.logger.info obj.inspect
      "Hello #{args.name}!"
    }
end

   field :login, types.String do
    argument :email, types.String
    argument :password, types.String
    is_public true

    resolve ->(_, args, _) {
      user = User.where(email: args[:email]).first
      user.sessions.create.key if user.try(:authenticate, args[:password])
    }
  end

    field :current_user, Types::UserType do
    resolve ->(_, _, ctx) { ctx[:current_user] }
  end

  field :user, Types::UserType do
    argument :id, types.ID
    description "One User"
    is_public true

    resolve -> (obj, args, ctx) {
      User.where(id: args.id).first
    }
end
   field :all_users, types[Types::UserType] do
    is_public true

    description 'Retrieves all users'
    resolve -> (_, _, _) { User.all }
end
  

  field :author, Types::AuthorType do 
    description "An author"
    argument :id, types.ID
    must_be [:superadmin]
    is_public true

    resolve ->(obj, args, ctx) {
      Author.where(id: args[:id]).first
    }
  end

  field :all_authors, types[Types::AuthorType] do
    description "All of the authors here"
    is_public true
    resolve ->(obj, args, ctx) { Author.all }
  end
end
