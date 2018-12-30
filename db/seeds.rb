# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'Example User',
             identity_name: 'example_user_1',
             email: 'example@railstutorial.org',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  identity_name = Faker::Number.number(10)
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               identity_name: identity_name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# message room
users = User.all
user = users.first
addressed_users = users[2..4]
addressed_users.each do |addressed_user|
  user.message_rooms.create!(sender_id: user.id,
                             receiver_id: addressed_user.id)
  addressed_user.message_rooms.create!(sender_id: addressed_user.id,
                                       receiver_id: user.id)
end
