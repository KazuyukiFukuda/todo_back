
def sign_in_as(email, password)
    post "/auth", params: {
        email: user.email,
        password: user.password
    }.to_json, header: {"Content-Type" => "application/json"}
end

def sign_up(display_name, email, password, password_confirmation)
    post "/users", params: { display_name: display_name, email: email, password: password, password_confirmation: password_confirmation}
end

def sign_up(user)
    post "/users",  params: {
        display_name: user.display_name,
        email: user.email,
        password: user.password,
        password_confirmation: user.password_confirmation
    }.to_json, headers: { "Content-Type" => "application/json" }
end