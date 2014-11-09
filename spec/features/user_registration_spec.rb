# Feature spec that will run through the user registration process.
# For now, this assumes you're allowed to register (you've been approved).
# Eventually, this spec will encompass the onboarding process as a whole.
require 'rails_helper'

feature 'User registrations' do
  before(:all) do
    Capybara.current_driver = :selenium # Slow, visual driver
    # Capybara.current_driver = :webkit   # Quick, headless driver
  end

  scenario "I can register for an account, and any typos are noted" do
    visit "/users/sign_up"

    # Let's input an invalid birthday and forget to select our gender at first
    fill_in "user[first_name]", with: 'James'
    fill_in "user[last_name]",   with: 'Dean'
    fill_in "birthdate_month",  with: 23
    fill_in "birthdate_day",    with: 04
    fill_in "birthdate_year",   with: 1984

    expect(page).not_to have_css(".help-block") # No showing errors until I click the button
    find_button("Continue").click
    expect(page).to have_css(".help-block", count: 2)

    # Let's be sure we're not showing step2 prematurely.
    expect(page).to have_selector(".step-2", visible: false)         

    # OK, let's fix those issues
    fill_in "birthdate_month",  with: 04
    first(".sex-select").click

    find_button("Continue").click

    expect(page).to have_selector(".step-2", visible: true)



  end


  after(:all) do
    Capybara.use_default_driver
  end
end