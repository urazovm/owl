Paperclip::Attachment.default_options.merge!(
  storage: :fog,
  fog_attributes: { 'Cache-Control' => 'max-age=315576000' },
  fog_public: true,
  fog_directory: ENV['S3_BUCKET']
  fog_credentials: {
    provider: 'AWS',
    aws_access_key_id: ENV['S3_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
    region: ENV['S3_REGION'],
  }
) if Rails.env.production?
