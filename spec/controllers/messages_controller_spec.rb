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
        @message1 = create(:message)
        @message2 = create(:message)
        @user.messages_received << @message1
        @user.messages_sent     << @message2
        
        
      end

      before(:each) do 
        sign_in :user, @user
        get :index 
      end
    

      it "renders the index view" do
        expect(response).to render_template(:index)
      end 

      it "returns 200 OK status" do
        expect(response.status).to eq(200)
      end

      it "returns the message sent to me" do
        expect(assigns[:inbox].first).to eq(@message1)
      end

      it "returns the message I sent to another user" do
        expect(assigns[:outbox].first).to eq(@message2)
      end
    end
  end



end
