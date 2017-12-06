Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :allLinks, !types[Types::LinkType] do
    # resolve would be called in order to fetch data for that field
    resolve ->(_obj, _args, _ctx) { Link.all }
  end
end
