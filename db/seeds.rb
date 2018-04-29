# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

####users####
User.create!(name:  "Jeffrey XIE",
             email: "xwy5201314@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

michael = User.create!(name:  "Michael Example",
             email: "michael@example.com",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

archer = User.create!(name:  "Sterling Archer",
             email: "duchess@example.gov",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)

lana = User.create!(name:  "Lana Kane",
             email: "hands@example.gov",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)

malory = User.create!(name:  "Malory Archer",
             email: "boss@example.gov",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)

george = User.create!(name:  "George King",
             email: "manager@example.gov",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)


99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

####clubs####
badminton = Club.create!(name: "Badminton",
             description: "Badminton is origianted from Badminton, UK")

basketball = Club.create!(name: "Basketball",
                              description: "Basketball is invented in USA")

football = Club.create!(name: "Football",
                              description: "Football is the most popular sport in the world")

hockey = Club.create!(name: "Hockey",
                               description: "Hockey is the national game of Canada")


####members####
badminton_admin = Member.create!(club: badminton, user: michael, admin: true, balance: 9.99)
badminton_member_lana = Member.create!(club: badminton, user: lana, balance: 9.99)

basketball_admin = Member.create!(club: basketball, user: archer, admin: true, balance: 9.99)
basketball_member_michael = Member.create!(club: basketball, user: michael, balance: 9.99)
basketball_member_malory = Member.create!(club: basketball, user: malory, balance: 9.99)

football_admin = Member.create!(club: football, user: michael, admin: true, balance: 9.99)

hockey_admin = Member.create!(club: hockey, user: george, admin: true, balance: 9.99)


####activities####
first_badminton = Activity.create!(club: badminton,
                                   name: 'Saturday night badminton',
                                   description: 'Come out and play',
                                   start_time: Time.now + 8.weeks,
                                   end_time: Time.now + 8.weeks + 1.hour,
                                   where: 'Sports Complex, court #1',
                                   total_cost: 8)

second_badminton = Activity.create!(club: badminton,
                                    name: 'Saturday night badminton',
                                    description: 'Come out and play',
                                    start_time: Time.now + 9.weeks,
                                    end_time: Time.now + 9.weeks + 2.hours,
                                    where: 'Sports Complex, court #2',
                                    total_cost: 16)

third_badminton = Activity.create!(club: badminton,
                                   name: 'Saturday night badminton',
                                   description: 'Come out and play',
                                   start_time: Time.now + 10.weeks,
                                   end_time: Time.now + 10.weeks + 1.hour,
                                   where: 'Sports Complex, courts #3 and #4',
                                   total_cost: 16)


first_basketball = Activity.create!(club: basketball,
                                   name: 'Our first basketball game',
                                   description: "Let's play it together",
                                   start_time: Time.now + 8.weeks,
                                   end_time: Time.now + 8.weeks + 1.hour,
                                   where: 'Sports Complex, 3F',
                                   total_cost: 12)

second_basketball = Activity.create!(club: basketball,
                                    name: 'Our second basketball game',
                                    description: "Let's play it again, guys",
                                    start_time: Time.now + 9.weeks,
                                    end_time: Time.now + 9.weeks + 2.hours,
                                    where: 'Sports Complex, 3F',
                                    total_cost: 24)

####players####
Player.create!(user: michael, activity: first_badminton)
Player.create!(user: lana, activity: first_badminton)

Player.create!(user: archer, activity: first_basketball)
Player.create!(user: michael, activity: first_basketball)
Player.create!(user: malory, activity: first_basketball)