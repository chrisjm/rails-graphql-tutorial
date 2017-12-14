class Resolvers::SignInUser < GraphQL::Function
  argument :email, !Types::AuthProviderEmailInput

  # defines the inline type for the mutation
  type do
    name 'SignInPayload'

    field :token, types.String
    field :user, Types::UserType
  end

  def call(_obj, args, ctx)
    input = args[:email]

    # basic validation
    return unless input

    user = User.find_by email: input[:email]

    # ensure correct user
    return unless user && user.authenticate(input[:password])

    # build token
    crypt = ActiveSupport::MessageEncryptor.new(
      Rails.application.secrets.secret_key_base.byteslice(0..31)
    )
    token = crypt.encrypt_and_sign("user-id:#{user.id}")

    ctx[:session][:token] = token

    OpenStruct.new(
      user: user,
      token: token
    )
  end
end
