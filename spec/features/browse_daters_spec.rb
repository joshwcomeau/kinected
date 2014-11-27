require 'rails_helper'

feature 'Browse Section. ' do
  include Capybara::Angular::DSL

  before(:all) do
    # Capybara.current_driver = :selenium # Slow, visual driver
    Capybara.current_driver = :webkit   # Quick, headless driver

    @user  = create(:user, sex: :male, email: 'john@doe.com')
    @conc  = create(:user, role: :concierge, sex: :female, email: 'concierge@gmail.com')
    
    @lady1 = create(:user, display_name: 'beatrice', sex: :female, last_sign_in_at: 2.hours.ago, created_at: 4.weeks.ago)
    @lady2 = create(:user, display_name: 'janiceee', sex: :female, last_sign_in_at: 2.minutes.ago, created_at: 2.week.ago, email: 'ja@gmail.com')
    @lady3 = create(:user, display_name: 'MissLuck', sex: :female, last_sign_in_at: 2.days.ago, created_at: 1.hour.ago)
    @lady4 = create(:user, display_name: 'xx_jesus', sex: :female, last_sign_in_at: 2.weeks.ago, created_at: 1.year.ago)
    
    @user.update(concierge_id: @conc.id)
    @lady2.update(concierge_id: @conc.id)

  end


  xscenario "Filter profiles by most recent login and newest users" do
    log_into_site('john@doe.com', '12345678')
    expect(page).to have_content(I18n.t ("devise.sessions.signed_in"))
    expect(current_path).to eq("/")

    find("#sidebar-browse-link").click
    expect(current_path).to eq(daters_path)
    sleep 2

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

  scenario "Sending a message, verifying its reception with notifications" do
    log_into_site('john@doe.com', '12345678')
    expect(page).to have_content(I18n.t ("devise.sessions.signed_in"))
    expect(current_path).to eq("/")
    expect(page).not_to have_css(".unread")
    find("#sidebar-browse-link").click

    expect(current_path).to eq(daters_path)
    expect(page).to have_content("janiceee")

    expect(page).not_to have_css("#message-modal")
    find("#message-button").click
    expect(find(:css, "#message-modal")).to be_visible

    fill_in "message_body", with: "Hey miss! I'm really happy to make your acquaintance <3"
    find("#send-message").click

    # Should send us back to root with a flash notice
    expect(current_path).to eq(root_path)
    expect(page).to have_content(I18n.t ("messages.create.sent"))

    # Let's check that the message, permission and activity were created
    expect(@user.messages_sent.count).to eq(1)
    expect(@user.permissions.count).to eq(1)
    expect(@lady2.activities.count).to eq(1)
    expect(@lady2.activities.first.seen).to eq(false)

    # Let's sign out and check that the message was delivered to Lady2
    find("#footer-signout-link").click
    log_into_site('ja@gmail.com', '12345678')

    # Check for dashboard notification
    expect(page).to have_css(".notification-row", count: 1)
    expect(page).to have_content(I18n.t 'notifications.messages.create', sender: @user.display_name)
    
    # Check for sidebar notification
    expect(page).to have_css(".unread")
  end


  # This test used the original, single-thumbnail profile page.
  # scenario "Test photo view" do
  #   log_into_site('john@doe.com', '12345678')
  #   expect(page).to have_content(I18n.t ("devise.sessions.signed_in"))
  #   expect(current_path).to eq("/")
  #   find("#sidebar-browse-link").click
  #   expect(current_path).to eq(daters_path)


  #   find(".profile-photo-container").click
  #   sleep 0.1
  #   expect(page).not_to have_css(".about-dater")
  #   expect(page).to have_css(".photo-header")
  #   expect(page).to have_css(".full-profile-photo")

  #   find(".return-to-profile").click
  #   expect(page).not_to have_css(".photo-header")
  #   expect(page).to have_css(".about-dater")

  # end

  after(:all) do
    Capybara.use_default_driver
  end
end