# your endpoint using sinatra for example
post '/users' do
  result = UpdateUser.new(User, config.mailer).call(params).to_result
  success_fnc = ->(obj) { obj.to_json }
  err_func = ->(msg) { { error: msg }.to_json }

  result.either(success_fnc, err_func)
end