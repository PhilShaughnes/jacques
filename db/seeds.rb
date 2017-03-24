# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This method adds 10 new users
def new_users
  print "\nadding 5 new users: "
  users = []
  5.times do
    print '.'
    user = User.create!(
      username: Faker::Pokemon.unique.name,
      email: Faker::Internet.unique.email,
      password: "password"
    )
    users << user
  end
  users
end

# #This method adds avatar urls to users who have none.
# # Note: Users created manually through the web interface will have an empty string for their avatar. This will not update those.
# def new_photo_url(users)
#   print "\nUpdating NULL avatar (Note: empty strings will not be updated): "
#   users.each do |user|
#     print '.'
#     user.photo_url ||= Faker::Avatar.image
#     user.save
#   end
# end

#This method adds between 1 and 5 posts for any users that have less than 2 posts.
def new_notes(users)
  print "\nchecking for notes: "
  users.each do |user|
    rand(1..5).times do
      print '.'
      note = user.notes.create!(
        title: Faker::Superhero.descriptor,
        body: Faker::ChuckNorris.fact
      )
      note.tags << Tag.find_or_create_by(name: Faker::StarWars.vehicle)
    end if user.notes.count < 2
  end
end


print "starting..."

#run the methods here.
# this runs new_users if there are less than 10 users in the database.
userslist = User.all.length < 5 ? new_users : User.all
new_notes(userslist)

puts "\nDone."
