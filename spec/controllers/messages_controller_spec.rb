require 'rails_helper'

RSpec.describe MessagesController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET :index" do
    before(:all) do
      @user = create(:user)
      @other_user = create(:user)

      # Create some messages
      @message1 = create(:message, status: 1)
      @message2 = create(:message, status: 1)
      @message3 = create(:message, status: 1)
      @user.messages_received << @message1
      @user.messages_sent     << @message2
      
    end    
    xcontext "when not logged in" do
      it "doesn't let us" do

        get :index 
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
      end   
    end
    
    xcontext "when logged in" do
      before(:each) do 
        sign_in :user, @user
        get :index 
      end

      it {
        is_expected.to render_template(:index)
      }

      it "returns 200 OK status" do
        expect(response.status).to eq(200)
      end

      it "returns the message sent to me" do
        expect(assigns[:inbox].first).to eq(@message1)
      end

      it "returns the message I sent to another user" do
        expect(assigns[:outbox].first).to eq(@message2)
      end

      it "assigns the @messages instance variable to a relation" do
        expect(assigns[:messages]).to be_a ActiveRecord::Relation
      end

      it "returns 2 messages, and not any others" do
        expect(assigns[:messages].count).to eq(2)
      end      
    end

    # Let's set both messages equal to 'rejected'. I should still see the message I received, but not the one I sent.
    describe "rejected message" do
      before(:all) do
        @message1.update(status: 4)
        @message2.update(status: 4)
      end
      before(:each) do 
        sign_in :user, @user
        get :index 
      end

      it "that I received doesn't show up" do
        expect(assigns[:messages]).not_to include(@message1)
      end

      it "that I sent does show up" do
        expect(assigns[:messages]).to include(@message2)
      end

      after(:all) do
        @message1.update(status: 1)
        @message2.update(status: 1)
      end
    end

    describe "queued message" do
      before(:all) do
        @message1.update(status: 4)
        @message2.update(status: 4)
      end
      before(:each) do 
        sign_in :user, @user
        get :index 
      end

      it "that I received doesn't show up" do
        expect(assigns[:messages]).not_to include(@message1)
      end

      it "that I sent does show up" do
        expect(assigns[:messages]).to include(@message2)
      end

      after(:all) do
        @message1.update(status: 1)
        @message2.update(status: 1)
      end
    end
  end

  xdescribe "POST :create" do
    context "when requesting JSON" do
      before(:all) do
        Message.destroy_all
        Permission.destroy_all
        User.destroy_all
        @user = create(:user)
        @other_user = create(:user)
      end

      before(:each) do
        sign_in :user, @user 
        xhr :post, :create, { message: {
          user_id:      @user.id,
          recipient_id: @other_user.id,
          body:         'Why hello there!'
        }, format: :json }
      end

      it "should persist the created message" do
        expect(Message.count).to eq(1)
      end 

      it "should respond with JSON" do
        json = JSON.parse(response.body)
        expect(json).to be_a Hash
        expect(json["result"]).to eq(true)
      end

    end
  end

end
