require 'rails_helper'

feature 'User login' do
  before(:all) do
    # Capybara.current_driver = :selenium # Slow, visual driver
    Capybara.current_driver = :webkit   # Quick, headless driver

    @user = create(:user, email: 'john@doe.com')
  end

  before(:each) do
    visit "/users/sign_in"    
  end

  scenario "I can sign in as a previously created user" do
    fill_in "user[email]",    with: 'john@doe.com'
    fill_in "user[password]", with: '12345678'
    find_button("Log In").click

    expect(page).to have_content(I18n.t ("devise.sessions.signed_in"))
  end

  scenario "I can't sign in with bogus info" do
    fill_in "user[email]",    with: 'johnadoe.com'
    fill_in "user[password]", with: 'wheee'
    find_button("Log In").click

    expect(page).to have_content(I18n.t("devise.failure.invalid"))
  end

  after(:all) do
    Capybara.use_default_driver
  end
end