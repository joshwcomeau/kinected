module FeatureHelpers
  def log_into_site(email, pass)
    visit new_user_session_path
    fill_in "user[email]",    with: email
    fill_in "user[password]", with: pass
    find_button("Log In").click
  end
end
