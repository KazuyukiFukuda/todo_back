def sign_in_as(email, password)
    post "/auth", params: {
        email: user.email,
        password: user.password
    }.to_json, header: {"Content-Type" => "application/json"}
end