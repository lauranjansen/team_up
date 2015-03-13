# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.destroy_all
User.destroy_all
Project.destroy_all

puts "\nSeeding roles..."
Role.create!(name: "Front end developer")
Role.create!(name: "Back end developer")
Role.create!(name: "Graphics designer")
Role.create!(name: "UX designer")
Role.create!(name: "Marketing")
Role.create!(name: "Operations")
Role.create!(name: "General")
Role.create!(name: "Advisor")
Role.create!(name: "QA/Tester")
9.times do
  print "|"
end

puts "\nCreating users..."
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    location: %w{ Toronto Montreal Vancouver}.sample,
    bio: Faker::Lorem.paragraph,
    password: "test",
    password_confirmation: "test"
  )
  print "|"
end

puts "\nCreating projects..."
20.times do
  Project.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    status: %w{ open in_progress finished }.sample,
    location: %w{ Toronto Montreal Vancouver}.sample,
    owner_id: User.all.sample.id
  )
  print "|"
end

puts "\nCreating positions..."
projects = Project.all
projects.each do |project|
  5.times do
    Position.create!(
      description: Faker::Lorem.paragraph,
      role_id: Role.all.sample.id,
      project_id: project.id
    )
    print "|"
  end
end

# positions = Position.all
# positions.each do |position|
#   if rand(2)
    
#   else

#   end
# end
