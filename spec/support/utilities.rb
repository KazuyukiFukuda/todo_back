def sign_in_as(user)
    post "/auth", params: {"email" => user.email, "password" => user.password}
end