# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all()

U1 = User.create ({
  first_name: "Aysha",
  last_name: "Eda",
  email: "Aysha@bitmaker.com",
  password: "password"

})

U2 = User.create ({
  first_name: "Rebecca",
  last_name: "Qu",
  email: "Rebecca@bitmaker.com",
  password: "password"
})