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
RSpec.describe ApplicationHelper, :type => :helper do
  describe "#fetch_content helper method" do
    before(:each) do
      # We're mocking the params hash
      params[:controller] = 'registrations'
      params[:action]     = 'new'
    end

    it "Fetches a string from en.yml" do
      expect(fetch_content(:big_title)).to eq(I18n.t "registrations.new.big_title")
    end

    it "Fetches a raw string from en.yml" do
      expect(fetch_content(:subtitle, :raw)).to eq(I18n.t "registrations.new.subtitle")
      # How do I test that it's converting html?
    end
  end
end
