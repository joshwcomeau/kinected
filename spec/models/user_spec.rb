# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  birthdate              :date
#  country                :string(255)
#  postal_code            :string(255)
#  sex                    :integer          default(0)
#  status                 :integer          default(0)
#  role                   :integer
#  latitude               :float
#  longitude              :float
#  self_summary           :text
#  height                 :integer
#  income                 :integer
#  num_of_kids            :integer
#  body_type              :string(255)
#  smoking                :string(255)
#  drinking               :string(255)
#  religion               :string(255)
#  education              :string(255)
#  work_industry          :string(255)
#  wants_kids             :string(255)
#  relationship_status    :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  display_name           :string(255)
#  city                   :string(255)
#  state                  :string(255)
#

require 'rails_helper'

RSpec.describe User, :type => :model do
  it "gets saved with a valid email and password" do
    user = build(:user)
    expect(user.save).to eq(true)
  end

  it "doesn't get saved when the password is too short" do
    user = build(:user, password: '123')
    expect(user.save).to eq(false)
    expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
  end

  it "doesn't get saved when the email isn't unique" do
    user1 = create(:user, email: 'john@doe.com')
    user2 = build(:user, email: 'john@doe.com')

    expect(user2.save).to eq(false)
    expect(user2.errors[:email]).to include("has already been taken")
  end

  it "has a default role of 'dater', and can be set to 'concierge' or 'admin'" do
    dater = create(:user)
    expect(dater.role).to eq("dater")

    concierge = create(:user, role: 1)
    expect(concierge.concierge?).to eq(true)

    admin = create(:user)
    admin.admin!
    expect(admin.role).to eq("admin")
  end

  it "can save associated ethnicities" do
    user = build(:user)
    user.ethnicities << Ethnicity.create(name: 'Asian')
    user.ethnicities << Ethnicity.create(name: 'White')

    expect(user.save).to eq(true)
    expect(user.ethnicities.count).to eq(2)
  end

  describe "match functions" do
    describe "#get_list_of_matches" do
      before(:all) do
        @me    = create(:user, sex: :male)
        @lady1 = create(:user, sex: :female, last_sign_in_at: 7.hours.ago, birthdate: 18.years.ago)
        @lady2 = create(:user, sex: :female, last_sign_in_at: 1.hours.ago, birthdate: 27.years.ago)
        @lady3 = create(:user, sex: :female, last_sign_in_at: 3.hours.ago, birthdate: 57.years.ago)
        @lady4 = create(:user, sex: :female, last_sign_in_at: 3.days.ago,  birthdate: 32.years.ago)
        @man1  = create(:user, sex: :male,   last_sign_in_at: 6.days.ago,  birthdate: 22.years.ago)
      end

      subject { @me.get_list_of_matches }
      
      it { is_expected.to be_a Array }
      
      it "returns an array of hashes" do
        expect(subject.first).to be_a Hash 
      end

      it "returns only the info we need in its hashes" do
        expect(subject.first.keys).to eq([:id, :joined, :last_seen])
      end

      it "returns the right number of results" do
        expect(subject.count).to eq(4)
      end

      it "orders the results, by default, by their last sign_in date" do
        expect(subject.first[:id]).to eq(@lady2.id)
        expect(subject.last[:id]).to  eq(@lady4.id)
      end


    end  

    describe "#get_full_match_data" do
      before(:all) do
        @me = create(:user, sex: :male)
        @q1 = create(:question, body: 'Are you crazy?')
        @q2 = create(:question, body: 'Are you hungry?')
        @q3 = create(:question, body: 'Are you bored?')
        @rails_user = create(:user, sex: :female)
        @rails_user.answers << Answer.new(question_id: Question.first.id, body: "yessir")
        @rails_user.answers << Answer.new(question_id: Question.second.id, body: "nossir")
        @user = @rails_user.get_full_match_data(@me)
      end

      describe "questions" do
        subject { @user[:answers_attributes] }

        it "is an array" do
          expect(subject).to be_a Array
        end

        it "contains 2 answers" do
          expect(subject.count).to eq(2)
        end

        it "contains the right data in a given answer" do
          expect(subject).to include({body: "yessir", id: @q1.id, question_body: "Are you crazy?"})
        end
      end

      describe "unanswered questions" do
        subject { @user[:unanswered_questions] }
              
        it "is an array" do
          expect(subject).to be_a ActiveRecord::Relation
        end

        it "contains 1 item" do
          expect(subject.count).to eq(1)
        end

        it "contains questions" do
          expect(subject.first).to be_a Question
        end

        it "contains the right question" do
          expect(subject.first).to eq(Question.last)
        end

      end


      describe "all photos" do
        subject { @user[:profile_photos] }
        
        it "is an array of photos" do
          expect(subject).to be_a ActiveRecord::AssociationRelation
        end

        it "contains the right number" do
          expect(subject.count).to eq(@rails_user.profile_photos.count)
        end

        it "contains the primary photo first" do
          expect(subject.first.photo_object.url).to eq(@rails_user.profile_photos.find_by(primary_photo: true).photo_object.url)
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
          expect(@user[:joined_ago]).to eq("less than a minute ago")
        end
        it "returns milliseconds since epoch" do
          expect(@user[:joined_num]).to eq(@rails_user.created_at.to_i * 1000)
        end
      end

      after(:all) do
        User.destroy_all
      end

    end
  end
end
