require 'dry/monads'

class UpdateUser
  include Dry::Monads[:result, :try]

  attr_reader :user_model, :mailer

  def initialize(user_model, mailer)
    @user_model = user_model
    @mailer = mailer
  end

  def call(fields)
    # running validations & convert result of validations to Success/Failure monad
    fields = yield UpdateValidator.new.call(fields).to_monad

    user = yield update_user(fields[:user], { name: fields[:name], email: fields[:email] })
    yield send_email(user, :profile_updated)

    Success(user)

    # different syntax for the method but with the same result
    # UpdateValidator.new.call(fields).to_monad
    #   .bind { |fields| update_user(fields[:user], { name: fields[:name], email: fields[:email] }) }
    #   .bind { |user| send_email(user, :profile_updated) }
  end

  private

  def update_user(user, data)
    if user.update(data)
      Success(user)
    else
      Failure(:user_update_failed)
    end
  end

  def send_email(email, reason)
    # Try is useful for wrapping code that can raise exception
    Try { mailer.deliver!(email, template: reason) }
  end
end
