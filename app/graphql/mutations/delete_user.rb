class Mutations::DeleteUser < GraphQL::Function
  description 'Delete user by their ID'

  argument :id, types.ID

  # What is returned
  type types.Boolean

  def call(obj, args, ctx)
    user = User.find(args[:id])
    # !! converts nil to false
    !!user.destroy
  end

end
