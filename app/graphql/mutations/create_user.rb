class Mutations::CreateUser < GraphQL::Function
  description 'Create a user'


  argument :user, Types::UserInputType

  type Types::UserType

  def call(obj, args, ctx)
    User.create args[:user].to_h
  end

end