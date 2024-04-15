User.destroy_all

users = [
  { email: ENV.fetch(TEST_USER_EMAIL_1, nil),
    password: ENV.fetch(TEST_USER_PASSWORD_1, nil),
    password_confirmation: ENV.fetch(TEST_USER_PASSWORD_1, nil) },
  { email: ENV.fetch(TEST_USER_EMAIL_2, nil),
    password: ENV.fetch(TEST_USER_PASSWORD_2, nil),
    password_confirmation: ENV.fetch(TEST_USER_PASSWORD_2, nil) },
  { email: ENV.fetch(TEST_USER_EMAIL_3, nil),
    password: ENV.fetch(TEST_USER_PASSWORD_3, nil),
    password_confirmation: ENV.fetch(TEST_USER_PASSWORD_3, nil) },
  { email: ENV.fetch(TEST_USER_EMAIL_4, nil),
    password: ENV.fetch(TEST_USER_PASSWORD_4, nil),
    password_confirmation: ENV.fetch(TEST_USER_PASSWORD_4, nil) },
  { email: ENV.fetch(TEST_USER_EMAIL_5, nil),
    password: ENV.fetch(TEST_USER_PASSWORD_5, nil),
    password_confirmation: ENV.fetch(TEST_USER_PASSWORD_5, nil) }
]

users.each do |fields|
  User.create!(fields)
end

Rails.logger.info "Created #{User.count} users"
