# Feature spec that will run through the user registration process.
# For now, this assumes you're allowed to register (you've been approved).
# Eventually, this spec will encompass the onboarding process as a whole.
require 'rails_helper'

feature 'User registrations' do
  include Capybara::Angular::DSL
  
  before(:all) do
    # Capybara.current_driver = :selenium # Slow, visual driver
    Capybara.current_driver = :webkit   # Quick, headless driver
  end

  scenario "I can register for an account, and any typos are noted" do
    visit "/users/sign_up"

    # Let's input an invalid birthday and forget to select our gender at first
    fill_in "user[first_name]",   with: 'James'
    fill_in "user[last_name]",    with: 'Dean'
    fill_in "user[display_name]", with: 'DaBadass'
    fill_in "birthdate_month",    with: 23
    fill_in "birthdate_day",      with: 04
    fill_in "birthdate_year",     with: 1984

    expect(page).not_to have_css(".help-block") # No showing errors until I click the button
    find_button("Continue").click

    # Let's check to see we're getting the right errors
    expect(page).to have_css(".help-block", count: 2)
    expect(page).to have_content(I18n.t("registrations.new.error_birthdate"))
    expect(page).to have_content(I18n.t("registrations.new.error_gender"))


    # Let's be sure we're not showing step2 prematurely.
    expect(page).to have_selector(".step-2", visible: false)         

    # OK, let's fix those issues
    fill_in "birthdate_month",  with: 04
    first(".sex-select").click
    find_button("Continue").click

    expect(page).to have_selector(".step-2", visible: true)
    expect(page).not_to have_selector(".step-3", visible: true)

    
    # Step 2: Photo upload. 
    # Let's check if the button says we can skip it.
    expect(page).to have_button("Skip")

    # Let's upload a photo!
    execute_script("$('#photo-object-field').show()")
    attach_file("photo-object-field", "/Users/Shared/sample1.jpg")

    find_button("Continue").click


    # Step 3: Account details
    expect(page).to have_selector(".step-3", visible: true)

    # Let's enter a bogus email and two slightly different passwords
    fill_in "user[email]",                  with: 'james@dean..com'
    fill_in "user[password]",               with: 'abcd1234'
    fill_in "user[password_confirmation]",  with: 'aBcd1234'

    # We're expecting 2 errors from this
    expect(page).not_to have_css(".help-block")
    find_button("Register").click

    expect(page).to have_css(".help-block", count: 2)
    expect(page).to have_content(I18n.t("registrations.new.error_email"))
    expect(page).to have_content(I18n.t("registrations.new.error_password_confirmation"))

    # Proper data for step 3
    fill_in "user[email]",                  with: 'james@dean.com'
    fill_in "user[password_confirmation]",  with: 'abcd1234'

    # Let's make sure that we can't submit the form with bogus data in earlier steps
    fill_in "birthdate_month",  with: 23
    find_button("Register").click

    expect(page).to have_css(".help-block", count: 1)
    expect(page).to have_content(I18n.t("registrations.new.error_birthdate"))
    

    # ok, good to go
    fill_in "birthdate_month",  with: 04
    find_button("Register").click

    expect(current_path).to eq("/")

    # Check that it persisted all fields
    expect(User.last.first_name).to eq("James")
    expect(User.last.last_name).to eq("Dean")
    expect(User.last.display_name).to eq("DaBadass")
    expect(User.last.birthdate).to eq("1984-04-04".to_date)
    
    expect(User.last.email).to eq("james@dean.com")


    # Check that it stored our role as dater
    expect(User.last.role).to eq("dater")

    # Check that it saved profile photo
    expect(User.last.profile_photos.count).to eq(1)
    expect(User.last.profile_photos.last.photo_object.url).to eq("/uploads/profile_photo/photo_object/#{User.last.profile_photos.first.id}/sample1.jpg")

  end

  after(:all) do
    Capybara.use_default_driver
  end
end