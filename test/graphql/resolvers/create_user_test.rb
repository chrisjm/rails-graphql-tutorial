require 'test_helper'

class Resolvers::CreateUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::CreateUser.new.call(nil, args, {})
  end

  test 'creating new link' do
    user = perform(
      name: 'John Doe',
      authProvider: {
        email: {
          email: 'john@example.com',
          password: 'password'
        }
      }
    )

    assert user.persisted?
    assert_equal user.name, 'John Doe'
    assert_equal user.email, 'john@example.com'
  end
end
