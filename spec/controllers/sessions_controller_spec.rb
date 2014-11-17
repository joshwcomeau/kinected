require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET :new" do
    before(:each) { get :new }

    it "assigns @user" do
      expect(assigns[:user]).to be_a_new(User)
    end 

    it "renders the login form" do
      expect(response).to render_template(:new)
    end 

    it "returns 200 OK status" do
      expect(response.status).to eq(200)
    end
  end

  describe "POST :create" do
    before(:all) do
      create(:user, email: 'john@doe.com', password: '12345678')
    end

    describe "successful logins" do
      before(:each) do
        post :create, user: { email: 'john@doe.com', password: '12345678' }
      end
    
      it "logs a user in with good credentials" do
        expect(warden.authenticated?(:user)).to eq(true)
      end
            
      it "redirects us to root after logging in" do
        post :create, user: { email: 'john@doe.com', password: '12345678' }
        expect(response).to redirect_to(root_path)
      end

      it "returns 302 Redirected status" do
        expect(response.status).to eq(302)
      end

      it "supplies the signed-in flash message" do
        expect(flash[:notice]).to eq(I18n.t("devise.sessions.signed_in"))
      end
    end
  end

  describe "unsuccessful logins" do
    before(:each) do
      post :create, user: { email: 'john@doe.com', password: 'abcdefgh' }
    end

    it "does not log a user in with bogus credentials" do
      expect(warden.authenticated?(:user)).to eq(false)
    end

    it "renders the same signup form for the user to try again" do
      expect(response).to render_template(:new)
    end

    it "returns 200 OK?" do
      expect(response.status).to eq(200)
    end

    it "supplies the error flash message" do
      expect(flash[:alert]).to eq(I18n.t("devise.failure.invalid"))
    end

  end
end
