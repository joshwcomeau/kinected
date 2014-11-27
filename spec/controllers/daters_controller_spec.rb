require 'rails_helper'

RSpec.describe DatersController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "PATCH :update" do
    before(:all) do
      @me    = create(:user, sex: :male)
    end

    context "when not signed in" do
      before(:each) do
        @me.self_summary = "lalala, updated summary"
        patch :update, {id: @me.id, user: @me}, {"Accept" => "application/json"}
        
      end

      it "responds with a flash alert" do
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
      end   
      it "responds with a 302 REDIRECT status" do
        expect(response.status).to eq(302)
      end      
      it "doesn't update the database" do
        expect(User.first.self_summary).not_to eq("lalala, updated summary")
      end
    end

    context "when signed in" do
      before(:each) do
        sign_in @me
      end

      # it "Updates the summary" do
      #   @me.self_summary = "lalala, updated summary"
      #   patch :update, @me
        
      #   expect(User.first.self_summary).to eq("lalala, updated summary")
      # end

      # it "Doesn't update an unpermitted param" do

      # end
    end
  end

  describe "GET :index" do
    before(:all) do
      @me    = create(:user, sex: :male)
      @lady1 = create(:user, sex: :female, last_sign_in_at: 6.days.ago)
      @lady2 = create(:user, sex: :female, last_sign_in_at: 3.hours.ago)
    end

    context "when not signed in" do
      before(:each) { get :index }

      it "doesn't let us" do
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
      end   
      it "responds with a 302 REDIRECT status" do
        expect(response.status).to eq(302)
      end      
      it "redirects us to the homepage" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "when signed in" do
      before(:each) do 
        sign_in @me
        get :index 
      end

      it "assigns the @daters variable" do
        expect(assigns[:daters]).to be_a Array
      end

      it "populates @daters with a bunch of users" do
        expect(assigns[:daters].first).to be_a Hash
      end

      it "assigns the @dater variable" do
        expect(assigns[:dater]).to be_a Hash
      end

      it "renders the show view" do
        expect(response).to render_template(:index)
      end

      it "returns 200 OK status" do
        expect(response.status).to eq(200)
      end
    end
  end

  describe "GET :edit" do
    before(:all) do
      @me    = create(:user, sex: :male)
      @other = create(:user, sex: :female)
    end

    describe "without being logged in" do
      before(:each) { get :edit, id: @me.id }
      it "doesn't let us" do
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
      end   
      it "responds with a 302 REDIRECT status" do
        expect(response.status).to eq(302)
      end      
      it "redirects us to the homepage" do
        expect(response).to redirect_to(root_path)
      end
    end

    describe "while signed in" do
      before(:each) { sign_in @me }

      describe "allows me to edit my own settings" do
        before(:each) do    
          get :edit, id: @me.id
        end

        it "assigns the @user variable" do
          expect(assigns[:dater]).to be_a User
        end

        it "creates a hash with the right user's data" do
          expect(assigns[:dater]["id"]).to eq(@me.id)
        end

        it "renders the edit view" do
          expect(response).to render_template(:edit)
        end

        it "returns 200 OK status" do
          expect(response.status).to eq(200)
        end
      end

      describe "doesn't allow me to view someone else's edit page" do
        before(:each) do
          get :edit, id: @other.id
        end

        it "Shows a flash error" do
          expect(flash[:alert]).to eq("You are not authorized to access this page.")
        end
        it "responds with a 302 REDIRECT status" do
          expect(response.status).to eq(302)
        end      
        it "redirects us to the homepage" do
          expect(response).to redirect_to(root_path)
        end

      end
    end
  end

  describe "GET :show" do
    before(:all) do
      @me   = create(:user, sex: :male)
      @them = create(:user, sex: :female)

      @concierge = create(:user, role: :concierge)
      @other_guy = create(:user, sex: :male)
    end

    describe "without being logged in" do
      before(:each) { get :show, id: @them.id }
      it "doesn't let us" do
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
      end   
      it "responds with a 302 REDIRECT status" do
        expect(response.status).to eq(302)
      end      
      it "redirects us to the homepage" do
        expect(response).to redirect_to(root_path)
      end
    end

    describe "while signed in" do
      before(:each) { sign_in @me }

      describe "allows me to view a member of the opposite sex's profile" do
        before(:each) do    
          get :show, id: @them.id
        end

        it "assigns the @user variable" do
          expect(assigns[:dater]).to be_a Hash
        end

        it "creates a hash with the right user's data" do
          expect(assigns[:dater]["id"]).to eq(@them.id)
        end

        it "renders the show view" do
          expect(response).to render_template(:show)
        end

        it "returns 200 OK status" do
          expect(response.status).to eq(200)
        end

        it "assigns @message to a new message object" do
          expect(assigns[:message]).to be_a Message
        end
      end

      describe "doesn't allow me to view a member of the same sex's profile. " do
        before(:each) do
          other_guy_id = @other_guy.id
          get :show, id: other_guy_id
        end

        it "Shows a flash error" do
          expect(flash[:alert]).to eq("You are not authorized to access this page.")
        end
        it "responds with a 302 REDIRECT status" do
          expect(response.status).to eq(302)
        end      
        it "redirects us to the homepage" do
          expect(response).to redirect_to(root_path)
        end

      end
    end
  end
end
