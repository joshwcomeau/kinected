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
        expect(@user[:joined]).to eq("less than a minute")
      end
    end


  end

  after(:all) do
    User.destroy_all
  end
end
