require 'rails_helper'

RSpec.describe ChatsController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET :show" do
    before(:all) do
      @me   = create(:user)
      @them = create(:user)
    end

    describe "without being logged in" do
      it "doesn't let us" do
        get :show, id: @them.id
        expect(flash[:alert]).to eq(I18n.t ("devise.failure.unauthenticated"))
      end   
    end

    describe "while logged in" do
      before(:each) do 
        sign_in @me 
      end

      it "but without being authorized by the other user" do
        @me.messages << create(:message, user: @me, recipient: @them)
        get :show, id: @them.id
        expect(flash[:alert]).to eq("Sorry, it appears as though this user does not wish to chat with you at this time.")
        Message.destroy_all
        Permission.destroy_all
      end

      it "but without first accepting their message to me" do
        @them.messages << create(:message, user: @them, recipient: @me)
        get :show, id: @them.id
        expect(flash[:alert]).to eq("I've blocked this user. To unblock them, find their message in the Messages page and click 'unblock'")
      end

      describe "and with the proper permissions" do
        before(:all) do
          @me.messages    << create(:message, user: @me, recipient: @them)
          @them.messages  << create(:message, user: @them, recipient: @me)
        end
        before(:each) do
          sign_in @me
          get :show, id: @them.id
        end

        it "assigns the @other_user variable" do
          expect(assigns[:other_user]).to eq(@them)
        end

        it "renders the show view" do
          expect(response).to render_template(:show)
        end

        it "returns 200 OK status" do
          expect(response.status).to eq(200)
        end
      end
    end
  end
end
