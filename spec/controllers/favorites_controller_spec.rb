require 'rails_helper'

RSpec.describe FavoritesController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  before(:all) do
    @me    = create(:user, sex: :male)
    @them  = create(:user, sex: :female)
  end

  describe "POST :create" do
    context "when not signed in" do
      before(:each) do
        post :create, {dater_id: @them.id}
      end

      it "responds with a flash alert" do
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
      end   
      it "responds with a 302 REDIRECT status" do
        expect(response.status).to eq(302)
      end      
      it "doesn't update the database" do
        expect(Favorite.all.count).to eq(0)
      end
    end

    context "when signed in" do
      before(:each) do
        sign_in @me
      end

      context "adding a new favorite when none exist" do
        before(:each) do
          post :create, {dater_id: @them.id}
        end

        it "responds with a 200 OK" do
          expect(response.status).to eq(200)
        end

        it "responds with a JSON confirmation" do
          expect(JSON.parse(response.body)["result"]).to eq(true)
        end

        it "creates the favorite" do
          expect(Favorite.all.count).to eq(1)
          expect(Favorite.first.user_id).to eq(@me.id)
          expect(Favorite.first.target_user_id).to eq(@them.id)
        end

      end

      context "trying to add a duplicate favorite" do
        before(:all) do
          Favorite.create(user_id: @me.id, target_user_id: @them.id)
        end
        before(:each) do
          post :create, {dater_id: @them.id}
        end

        it "responds with a JSON confirmation of failure" do
          expect(JSON.parse(response.body)["result"]).to eq(false)
        end

        it "doesn't create the favorite" do
          expect(Favorite.all.count).to eq(1)
        end

        after(:all) do
          Favorite.destroy_all
        end
      end
    end
  end

  describe "DELETE :destroy" do
    context "when not signed in" do
      before(:each) do
        delete :destroy, {dater_id: @them.id}
      end

      it "responds with a flash alert" do
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
      end   
      it "responds with a 302 REDIRECT status" do
        expect(response.status).to eq(302)
      end      
      it "doesn't update the database" do
        expect(Favorite.all.count).to eq(0)
      end
    end
  end


end
