require 'carrierwave/test/matchers'

describe ProfilePhotoUploader do
  include CarrierWave::Test::Matchers

  before do
    @sample_path = '/Users/house/work/kinected/app/assets/images/samples/sample1.jpg'
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
    it "should scale down a larger image to be exactly 300 by 300 pixels" do
      expect(@uploader.thumb).to have_dimensions(300, 300)
    end
  end


end