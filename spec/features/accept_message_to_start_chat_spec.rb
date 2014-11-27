require 'rails_helper'

feature 'Accept message' do
  include Capybara::Angular::DSL
  before(:all) do
    # Capybara.current_driver = :selenium # Slow, visual driver
    Capybara.current_driver = :webkit   # Quick, headless driver

    @user = create(:user, email: 'john@doe.com')
    @other_user = create(:user, email: 'jane@doe.com')

    @other_user.messages_sent.create({
      recipient_id: @user.id,
      body: 'Hey there partner'
    })


  end

  scenario "to start a new chat" do
    log_into_site('john@doe.com', '12345678')
    expect(page).to have_content(I18n.t ("devise.sessions.signed_in"))
    expect(current_path).to eq("/")

    find("#sidebar-messages-link").click
    expect(current_path).to eq(messages_path)

    # We should have a single incoming message
    expect(page).to have_css(".inbox-message-row", count: 1)
    expect(find(".message_preview")).to have_content('Hey there partner')

    # The message should be in the 'sent' status, so it ought to have an 'accept and chat' link
    expect(page).to have_css(".accept-button", count: 1)

    # Let's quickly test that the database has the right permissions
    expect(Permission.count).to eq(1)
    expect(Permission.first.user_id).to eq(@other_user.id)
    expect(Permission.first.target_user_id).to eq(@user.id)
    expect(Permission.first.status).to eq("allowed")

    # Let's accept it!
    find(".accept-button").click
    expect(find(".alert-success")).to have_content(I18n.t("flash_messages.permissions.create.success"))

    # Now the 'accept' button ought to have been swapped for a chat link.
    find(".chat-link").click

    expect(current_path).to eq(chat_path(id: @other_user.id))
    
    # Let's make sure everything in the database is correct
    expect(Permission.count).to eq(2)
    expect(Permission.last.user_id).to eq(@user.id)
    expect(Permission.last.target_user_id).to eq(@other_user.id)
    expect(Permission.last.status).to eq("allowed")
  end

  after(:all) do
    Capybara.use_default_driver
  end
end