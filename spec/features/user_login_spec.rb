require 'rails_helper'

feature 'User login' do
  include Capybara::Angular::DSL
  
  before(:all) do
    # Capybara.current_driver = :selenium # Slow, visual driver
    Capybara.current_driver = :webkit   # Quick, headless driver

    @user = create(:user, email: 'john@doe.com')
  end

  scenario "I can sign in as a previously created user" do
    log_into_site('john@doe.com', '12345678')

    expect(page).to have_content(I18n.t ("devise.sessions.signed_in"))
    expect(current_path).to eq("/")
  end

  scenario "I can't sign in with bogus info" do
    log_into_site('john@doe.com', 'wheee')

    expect(page).to have_content(I18n.t("devise.failure.invalid"))
    expect(current_path).to eq(new_user_session_path)
  end

  after(:all) do
    Capybara.use_default_driver
  end
end