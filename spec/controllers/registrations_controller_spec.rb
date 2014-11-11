require 'rails_helper'

RSpec.describe RegistrationsController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET :new" do
    before(:each) { get :new }

    it "assigns @user" do
      expect(assigns[:user]).to be_a_new(User)
    end 

    it "renders the signup form" do
      expect(response).to render_template(:new)
    end 

    it "returns 200 OK status" do
      expect(response.status).to eq(200)
    end
  end


  describe "POST :create" do
    before(:each) do
      post :create, {
        birthdate_year: '1986', 
        birthdate_month: '05', 
        birthdate_day: '29',

        user: { 
          email: 'john@doe.com', 
          password: '12345678', 
          sex: 'male',
          first_name: 'John',
          last_name: 'Doe'
        }
      }
    end

    it "persists the user data we pass in" do
      expect(assigns[:user]).to eq(User.last)
    end

    it "signs us in automatically" do
      expect(warden.authenticated?(:user)).to eq(true)
    end

    it "redirects to the root path" do
      expect(response).to redirect_to(root_path)
    end

    it "returns 302 Redirected status" do
      expect(response.status).to eq(302)
    end
  end


end
