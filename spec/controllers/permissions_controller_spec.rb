require 'rails_helper'

RSpec.describe PermissionsController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "POST :create" do
    before(:each) do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
    end

    describe "invalid" do
      it "doesn't let us when we aren't logged in" do
        post :create, {
          permission: { 
            user_id:        @user1.id, 
            target_user_id: @user2.id,
            status:         'allowed'
          }
        }
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
        expect(assigns[:permission]).not_to be_persisted
        expect(response).to redirect_to(root_path)

      end

      it "doesn't let us create permissions for other users" do
        sign_in :user, @user1
        post :create, {
          permission: { 
            user_id:        @user2.id, 
            target_user_id: @user3.id,
            status:         'allowed'
          }
        }
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
        expect(assigns[:permission]).not_to be_persisted
        expect(response).to redirect_to(root_path)
      end   
    end
    
    describe "valid - creating an 'allowed' permission" do
      before(:each) do
        sign_in :user, @user1
        post :create, {
          permission: { 
            user_id:        @user1.id, 
            target_user_id: @user2.id,
            status:         'allowed'
          }
        }
      end

      it "persists the new permission" do
        expect(assigns[:permission]).to be_persisted
      end

      it "saves all the data correctly" do
        expect(assigns[:permission].user_id).to eq(@user1.id)
        expect(assigns[:permission].target_user_id).to eq(@user2.id)
        expect(assigns[:permission].status).to eq('allowed')
      end

      it "responds with either 200 OK or 302 REDIRECTED" do
        expect([200, 302]).to include(response.status)
      end
    end
  end
end
