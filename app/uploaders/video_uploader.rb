class VideoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def extension_whitelist
    %w(mp4 mov wmv mpeg4 avi 3gpp webm)
  end

  def default_public_id
    "videonotfound"
  end
end
