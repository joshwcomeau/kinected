# encoding: utf-8

class ProfilePhotoUploader < CarrierWave::Uploader::Base
  @@thumb_size = 250

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include CarrierWave::Processing::RMagick
  

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/images/default_profile_photo.png"
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  version :thumb do
    process resize_to_fill: [@@thumb_size, @@thumb_size]
  end

  version :rectangle_thumb do
    process resize_to_fill: [400, 300]
  end

  version :blurred_thumb do
    process resize_to_fill: [@@thumb_size, @@thumb_size]
    process blur:           [18, 8]
  end
  
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
