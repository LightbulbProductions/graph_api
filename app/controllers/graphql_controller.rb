class GraphqlController < ApplicationController
before_action :check_authentication
    
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: @session.try(:user),
      session_key: @session.try(:key)
    }
    result = GraphApiSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private
  
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def check_authentication
    parsed_query = GraphQL::Query.new GraphApiSchema, params[:query]
    operation = parsed_query.selected_operation.selections.last.name
    return true if operation == '__schema'

    field = GraphApiSchema.query.fields[operation] || GraphApiSchema.mutation.fields[operation]
    return true if field.metadata[:is_public]

    unless @session = Session.where(key: request.headers['Authorization']).first
      head(:unauthorized)
      return false
    end

    unless field.metadata[:must_be].to_a.include? @session.user.role
      head(:unauthorized)
     return false
   end
  end
end
