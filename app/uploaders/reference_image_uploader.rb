# encoding: utf-8

class ReferenceImageUploader < CarrierWave::Uploader::Base  
  include CarrierWave::MimeTypes
  storage :file
  
  process :set_content_type
  process :save_content_type_and_size
  
  def save_content_type_and_size
    model.content_type = file.content_type if file.content_type
    model.file_size = file.size
  end


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
