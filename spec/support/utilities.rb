def sign_up(display_name, email, password, password_confirmation)
    post "/users", params: { display_name: display_name, email: email, password: password, password_confirmation: password_confirmation}
end