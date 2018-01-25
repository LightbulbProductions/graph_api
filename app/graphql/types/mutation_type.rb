Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  description "crud"

 field :createAuthor, Types::AuthorType do
    argument :author, Types::AuthorInputType
    resolve ->(_, args, _) do
      is_public true
      Author.create args[:author].to_h
    end
  end

  field :updateAuthor, Types::AuthorType do
    argument :id, types.ID
    argument :author, Types::AuthorInputType
    resolve -> (_, args, _) do
      is_public true
      author = Author.find(args[:id])
      author.try :update, args[:author].to_h
      author
    end
  end

  field :deleteAuthor, Types::AuthorType do
    argument :id, types.ID
    type types.Boolean
    resolve -> (_, args, _) do
      is_public true

      author = Author.find(args[:id])
      # !! converts nil to false
      !!author.destroy
    end
  end

# mutations for users
  field :createUser, Types::UserType do
    argument :user, Types::UserInputType
    resolve ->(_, args, _) do
      is_public true
      User.create args[:user].to_h
    end
  endUser

  field :updateUser, Types::UserType do
    argument :id, types.ID
    argument :user, Types::UserInputType
    resolve -> (_, args, _) do
      is_public true
      user = User.find(args[:id])
      user.try :update, args[:user].to_h
      user
    end
  end

  field :deleteUser, Types::UserType do
    argument :id, types.ID
    type types.Boolean
    resolve -> (_, args, _) do
      is_public true

      user = User.find(args[:id])
      # !! converts nil to false
      !!user.destroy
    end
  end

  field :logout, types.Boolean do
    is_public true
    resolve -> (_, _, ctx) { Session.where(key: c[:session_key]).destroy_all }
  end
end