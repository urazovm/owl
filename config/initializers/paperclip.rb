Paperclip::Attachment.default_options.merge!(
  storage: :s3,
  s3_permissions: :private,
  s3_credentials: {
    bucket: ENV['AS3_BUCKET'],
    access_key_id: ENV['AS3_ACCESS_KEY_ID'],
    secret_access_key: ENV['AS3_SECRET_ACCESS_KEY']
  }
) if Rails.env.production?
