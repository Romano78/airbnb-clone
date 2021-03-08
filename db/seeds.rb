require 'faker'
require 'open-uri'

puts "deleting Bookings: #{Booking.delete_all}"
puts "deleting Flats: #{Flat.delete_all}"
puts "deleting Users: #{User.delete_all}"
Flat.reset_pk_sequence

puts 'creating seed...'

bob = User.new(name: 'bob', last_name: 'sponge', admin: true, email: 'bob@sponge.com', password: '222222')
bill = User.new(name: 'Bill', last_name: 'Cosby', email: 'bill@cosby.com', password: '222222')

bob.save
bill.save

puts "creating #{bob}"
puts "creating #{bill}"

3.times do
  bob_flat = Flat.new(
    name: Faker::TvShows::SouthPark.character,
    address: Faker::Address.street_address,
    description: Faker::TvShows::SouthPark.quote,
    rating: (1..5).to_a.sample,
    user_id: bob.id
  )

  bob_flat.save

  # bob_file = URI.open('https://source.unsplash.com/gREquCUXQLI/600x400')
  # bob_flat.photo.attach(io: bob_file, filename: 'test', content_type: 'image/jpg')

  puts "saving #{bob_flat}"

  bill_flat =  Flat.new(
    name: Faker::TvShows::SouthPark.character,
    address: Faker::Address.street_address,
    description: Faker::TvShows::SouthPark.quote,
    rating: (1..5).to_a.sample,
    user_id: bill.id
  )

  bill_flat.save

  # easer way where you assign a photo manually

  # file = URI.open('https://source.unsplash.com/gREquCUXQLI/600x400')
  # bill_flat.photo.attach(io: file, filename: 'test', content_type: 'image/jpg')

  puts "saving #{bill_flat}"
end

# More difficulte way with random photos for all the condos

url = [
  'https://source.unsplash.com/gREquCUXQLI/600x400',
  'https://source.unsplash.com/jn7uVeCdf6U/600x400',
  'https://source.unsplash.com/9LMRQdVv7hw/600x400',
  'https://source.unsplash.com/oTJ92KUXHls/600x400',
  'https://source.unsplash.com/jUOaONoXJQk/600x400',
  'https://source.unsplash.com/N90LM3A5AZQ/600x400'
]

i = 0

while i < url.length
  p 'while...'
  file = URI.open(url[i])
  photo = Flat.find(i + 1).photo.attach(io: file, filename: "#{Flat.find(i + 1).name.downcase.gsub(' ', '_')}.jpg",
                                        content_type: 'image/jpg')
  i += 1
  p "creating #{file}: #{photo}"
end
puts 'finished'
