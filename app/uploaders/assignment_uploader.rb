class AssignmentUploader < CarrierWave::Uploader::Base
  # include CarrierWave::RMagick

  if Rails.env.test? || Rails.env.development?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
