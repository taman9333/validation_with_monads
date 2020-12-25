require 'dry/validation'

class UpdateValidator < Dry::Validation::Contract
  params do
    required(:email).value(:string)
    required(:password).value(:string)
    required(:name).value(:string)
    required(:id).value(:integer)
  end

  rule(:email) do
    key.failure('email has invalid format') if URI::MailTo::EMAIL_REGEXP.match?(value)
  end

  rule(:id) do
    user = User.find_by(id: value)

    # if user exists include it in validator hash values.
    # so we don't have to fetch the user record again after validation
    if user
      values[:user] = user
    else
      key.failure('user could not be found')
    end
  end
end
