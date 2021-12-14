module LoginMacros

  def login(user)
    post user_session_path, params:  { email: user.email, password: user.password }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    get_auth_params_from_login_response_headers(response)
  end

  def not_login
    params = {
      'access-token' => "not-login",
      'client' => "not-login",
      'uid' => "not-login"
    }
    params
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid
    }
    auth_params
  end


end
