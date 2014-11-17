require 'rails_helper'

feature 'Browse' do
  before(:all) do
    # Capybara.current_driver = :selenium # Slow, visual driver
    Capybara.current_driver = :webkit   # Quick, headless driver

    @user  = create(:user, sex: :male, email: 'john@doe.com')
    @lady1 = create(:user, display_name: 'beatrice', sex: :female, last_sign_in_at: Time.now)
    @lady2 = create(:user, display_name: 'janiceee', sex: :female, last_sign_in_at: Time.now)
    @lady3 = create(:user, display_name: 'MissLuck', sex: :female, last_sign_in_at: Time.now)
    @lady4 = create(:user, display_name: 'xx_jesus', sex: :female, last_sign_in_at: Time.now)

  end

  scenario "view several profiles" do
    log_into_site('john@doe.com', '12345678')
    expect(page).to have_content(I18n.t ("devise.sessions.signed_in"))
    expect(current_path).to eq("/")

    find("#sidebar-browse-link").click
    expect(current_path).to eq(daters_path)
    expect(page).to have_content("xx_jesus")

    find(".next-match-button").click

    expect(page).not_to have_content("xx_jesus")
    expect(page).to have_content("MissLuck")


  end

  after(:all) do
    Capybara.use_default_driver
  end
end