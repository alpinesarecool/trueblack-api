module Resolvers
  module Mutations
    class Login < GraphQL::Schema::Mutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :token, String, null: true
      field :errors, [String], null: false

      def resolve(email:, password:)
        user = User.find_by(email: email)
        if user && user.authenticate(password)
          token = "example_token"
          { token: token, errors: [] }
        else
          { token: nil, errors: ["Invalid email or password"] }
        end
      end
    end
  end
end
