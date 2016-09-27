def authenticate(user)
  token = Knock::AuthToken.new(payload: { sub: user.id }).token
  { HTTP_AUTHORIZATION: "Bearer #{token}" }
end