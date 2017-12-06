Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createLink, function: Resolvers::CreateLink.new
  field :createUser, function: Resolvers::CreateUser.new
end
