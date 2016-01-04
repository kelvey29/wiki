require 'faker'
include Faker

#Create Wiki Data
20.times do
   Wiki.create!(
       :title => Faker::Lorem.words.join('<'),
       :body => Faker::Lorem.paragraphs.join('<br/>'),
       :private => false
   ) 
end

10.times do
   User.create!(
      :email => Faker::Internet.email,
      :password => Faker::Internet.password(8)
   )
end
   
puts "Seed finished"

puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
