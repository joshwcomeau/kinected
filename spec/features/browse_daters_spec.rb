require 'rails_helper'

feature 'Browse' do
  before(:all) do
    Capybara.current_driver = :selenium # Slow, visual driver
    # Capybara.current_driver = :webkit   # Quick, headless driver

    @user  = create(:user, sex: :male, email: 'john@doe.com')
    @lady1 = create(:user, display_name: 'beatrice', sex: :female, last_sign_in_at: 2.hours.ago, created_at: 4.weeks.ago)
    @lady2 = create(:user, display_name: 'janiceee', sex: :female, last_sign_in_at: 2.minutes.ago, created_at: 2.week.ago)
    @lady3 = create(:user, display_name: 'MissLuck', sex: :female, last_sign_in_at: 2.days.ago, created_at: 1.hour.ago)
    @lady4 = create(:user, display_name: 'xx_jesus', sex: :female, last_sign_in_at: 2.weeks.ago, created_at: 1.year.ago)
  end


  scenario "Filter profiles by most recent login and newest users" do
    log_into_site('john@doe.com', '12345678')
    expect(page).to have_content(I18n.t ("devise.sessions.signed_in"))
    expect(current_path).to eq("/")

    find("#sidebar-browse-link").click
    expect(current_path).to eq(daters_path)

    # The default sort is 'last sign in'. Let's make sure they're ordered accordingly. First Janicee, then Beatrice
    expect(page).to have_content("janiceee")
    find(".next-button").click
    expect(page).not_to have_content("janiceee")
    expect(page).to have_content("beatrice")

    # Cool. Now lets switch to newest users, and make sure we see MissLuck and then Janiceee
    find('#order-select').find(:xpath, 'option[2]').select_option
    expect(page).not_to have_content("beatrice")
    expect(page).to have_content("MissLuck")
    find(".next-button").click
    expect(page).not_to have_content("MissLuck")
    expect(page).to have_content("janiceee")
  end

  after(:all) do
    Capybara.use_default_driver
  end
end