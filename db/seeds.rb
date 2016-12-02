# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


10.times do
  User.create(username: FFaker::Internet.user_name, email: FFaker::Internet.email, password: "password", password_confirmation: "password")
  10.times do
    Post.create(body: "Sweet post bro", user_id: User.last.id)
  end
end
