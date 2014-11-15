require 'carrierwave/test/matchers'
require 'rails_helper'

describe ProfilePhotoUploader do
  include CarrierWave::Test::Matchers

  before do
    @sample_path = '/Users/Shared/sample1.jpg'
    @photo = ProfilePhoto.create
    ProfilePhotoUploader.enable_processing = true
    @uploader = ProfilePhotoUploader.new(@photo, :photo_object)
    @uploader.store!(File.open(@sample_path))
  end

  after do
    ProfilePhotoUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the thumb version' do
    it "should scale down a larger image to be exactly 250 by 250 pixels" do
      expect(@uploader.thumb).to have_dimensions(250, 250)
    end
  end


end