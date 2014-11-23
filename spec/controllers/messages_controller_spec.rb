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

    context "when not logged in" do
      it "doesn't let us" do

        get :index 
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
      end   
    end
    
    context "when logged in" do
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

    after(:all) do
      Message.destroy_all
      Permission.destroy_all
      User.destroy_all
    end    

  end

  describe "POST :create" do
    before(:all) do
      @user = create(:user)
      @other_user = create(:user)
      @third_user = create(:user)
    end    
  
    context "when requesting JSON" do
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

      it "should create an activity feed notification for the recipient" do
        expect(@other_user.activities.last.trackable_id).to eq(Message.last.id)
      end
    end 

    describe "limitations" do
      before(:all) { Message.create(user_id: @user.id, recipient_id: @third_user.id, body: 'hey sexy') }

      before(:each) do
        sign_in :user, @user 
        xhr :post, :create, { message: {
          user_id:      @user.id,
          recipient_id: @other_user.id,
          body:         'Why hello there!'
        }, format: "json" }
      end      

      it "won't persist additional messages" do
        expect(@user.messages.count).to eq(1)
        expect(@user.messages.first.body).to eq('hey sexy')
      end

      it "returns 'false' via JSON" do
        json = JSON.parse(response.body)
        expect(json).to be_a Hash
        expect(json["result"]).to eq(false)
      end

      it "returns an error message as part of the response" do
        json = JSON.parse(response.body)
        expect(json["message"]).to eq(I18n.t("messages.create.exceeded_limit"))
      end

      it "doesn't create an activity feed notification" do
        expect(Activity.count).to eq(0)
      end

      after(:all) { @user.messages.destroy_all }
    end
  end

end
