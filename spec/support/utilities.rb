

def sign_in_as(email, password)
    post "/auth", params: {
        email: email,
        password: password
    }.to_json, headers: {"Content-Type" => "application/json"}
end

def sign_up(user)
    post "/users",  params: {
        display_name: user.display_name,
        email: user.email,
        password: user.password,
        password_confirmation: user.password_confirmation
    }.to_json, headers: { "Content-Type" => "application/json" }
end