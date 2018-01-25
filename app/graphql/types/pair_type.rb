  Types::PairType = GraphQL::ObjectType.define do
     name 'PairType'
     description 'A pair of coordinates'

     field :latitude, types.Float do
       resolve ->(obj, _, _) { obj.first }
     end

     field :longitude, types.Float do
       resolve ->(obj, _, _) { obj.last }
     end
   end