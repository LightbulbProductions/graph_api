Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :testField, types.String do
    argument :name, types.String, "Enter Your Name"
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      "Hello #{args[:name]}"
    }
  end

  field :author, Types::AuthorType do
    argument :id, types.ID 
    description "An author"
    resolve ->(obj, args, ctx) {
      Author.where(id: args[:id]).first
    }
  end
end
