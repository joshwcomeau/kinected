require 'rails_helper'

RSpec.describe MessagesController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET :index" do
    describe "without being logged in" do
      it "doesn't let us" do
        expect { get :index }.to raise_exception(CanCan::AccessDenied)
      end   
    end
    
    describe "while logged in" do
      before(:all) do
        @user = create(:user)
        @other_user = create(:user)

        # Create some messages
        @user.messages_sent     << create(:message)
        @user.messages_received << create(:message)
        
        sign_in :user
      end
      before(:each) { get :index }
    end

    it "renders the index view" do
      expect(response).to render_template(:index)
    end 

    it "returns 200 OK status" do
      expect(response.status).to eq(200)
    end
  end



end
