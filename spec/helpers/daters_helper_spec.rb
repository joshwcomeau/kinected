require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DatersHelper, :type => :helper do
  describe "#format_user_for_angular" do
    before(:all) do
      @rails_user = create(:user)
      @user = format_user_for_angular(@rails_user)
    end

    describe "primary photo" do
      subject { @user[:primary_profile_photo] }

      it "is a photo" do
        expect(subject).to be_a ProfilePhoto
      end
      it "is primary" do
        expect(subject.primary).to eq(true)
      end
      it "contains a full URL" do
        expect(subject.photo_object.url).to be_a String
      end
      it "contains a thumb URL" do
        expect(subject.photo_object.thumb.url).to be_a String
      end

    end

    describe "non-primary photos" do
      subject { @user[:profile_photos] }
      
      it "is a relation" do
        expect(subject).to be_a ActiveRecord::AssociationRelation
      end

      it "contains the right number (1 less than total)" do
        expect(subject.count).to eq(@rails_user.profile_photos.count - 1)
      end

      it "contains non-primary photos exclusively" do
        expect(subject.map(&:primary).uniq.count).to eq(1)
        expect(subject.map(&:primary).uniq.first).to eq(false)
      end

      it "contains a full URL" do
        expect(subject.first.photo_object.url).to be_a String
      end
      it "contains a thumb URL" do
        expect(subject.first.photo_object.thumb.url).to be_a String
      end
      it "contains a 7thumb URL" do
        expect(subject.first.photo_object.blurred_thumb.url).to be_a String
      end
    end

    describe "formatted times" do
      it "formats in words their time since joining the site" do
        expect(@user[:joined_ago]).to eq("less than a minute")
      end
      it "returns milliseconds since epoch" do
        expect(@user[:joined_num]).to eq(@rails_user.created_at.to_i * 1000)
      end
    end

    after(:all) do
      User.destroy_all
    end
  end

  describe "#format_user_list_for_angular" do
    before(:all) do
      @me     = create(:user, sex: 'male')
      @girl1  = create(:user, sex: 'female')
      @girl2  = create(:user, sex: 'female')
      @girl3  = create(:user, sex: 'female')
      @girl4  = create(:user, sex: 'female')
      @girl5  = create(:user, sex: 'female')
      @users  = format_user_list_for_angular(@me.get_valid_matches)
    end

    it "gets the right number of users" do
      expect(@users.count).to eq(5)
    end

    describe "the first user" do
      subject { @users.first }
      it "pulls out their ID" do
        expect(subject[:id]).to eq(@girl1.id)
      end

      it "grabs their blurred thumb URL" do
        expect(subject[:thumb]).to eq(@girl1.profile_photos.find_by(primary: true).photo_object.blurred_thumb.url)
      end

      it "grabs their last seen date" do

      end

      it "grabs their last seen string" do

      end
    end

    after(:all) do
      User.destroy_all
    end
  end
end
