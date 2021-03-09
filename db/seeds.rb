require 'faker'
require 'open-uri'

puts "deleting Bookings: #{Booking.delete_all}"
puts "deleting Flats: #{Flat.delete_all}"
puts "deleting Users: #{User.delete_all}"
Flat.reset_pk_sequence
User.reset_pk_sequence

puts 'creating seed...'

bob = User.new(name: 'bob', last_name: 'sponge', admin: true, email: 'bob@sponge.com', password: '222222')

bob_file = URI.open('https://source.unsplash.com/fCnU57cVwTY/200x200')
bob.avatar.attach(io: bob_file, filename: 'Bob Avatar', content_type: 'image/jpg')

bill = User.new(name: 'Bill', last_name: 'Murray', email: 'bill@cosby.com', password: '222222')
bill_file = URI.open('https://source.unsplash.com/kVg2DQTAK7c/200x200')
bill.avatar.attach(io: bill_file, filename: 'Bill Avatar', content_type: 'image/jpg')

bob.save
bill.save

puts "creating #{bob}"
puts "creating #{bill}"

bill_random_address = ['4526 Av Harvard Montréal QC H4A 2X2', '4202 Country Dr, Vernon, TX',
                       '16116 33rd Ave, Flushing, NY', '4, Place du Louvre  75042 Paris ', "8, rue de la Banque
                       75084 Paris", '1222 June Way, Pasadena, MD']

bob_random_address = ['3151  Doctors Drive', '16 Villa Gaudelet, Paris', "2, rue Eugène Spuller
                      75003 Paris", "2, Place Baudoyer
                      75181 Paris "]

3.times do
  bob_flat = Flat.new(
    name: Faker::TvShows::SouthPark.character,
    address: bob_random_address.sample,
    description: Faker::TvShows::SouthPark.quote,
    rating: (1..5).to_a.sample,
    user_id: bob.id
  )

  bob_flat.address = bob_random_address.sample unless bob_flat.address != bob_flat.address

  bob_flat.save

  # bob_file = URI.open('https://source.unsplash.com/gREquCUXQLI/600x400')
  # bob_flat.photo.attach(io: bob_file, filename: 'test', content_type: 'image/jpg')

  puts "saving #{bob_flat}"

  bill_flat =  Flat.new(
    name: Faker::TvShows::SouthPark.character,
    address: bill_random_address.sample,
    description: Faker::TvShows::SouthPark.quote,
    rating: (1..5).to_a.sample,
    user_id: bill.id
  )

  bill_flat.address = bill_random_address.sample unless bill_flat.address != bill_flat.address

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

p 'while...'
while i < url.length
  file = URI.open(url[i])
  photo = Flat.find(i + 1).photo.attach(io: file, filename: "#{Flat.find(i + 1).name.downcase.gsub(' ', '_')}.jpg",
                                        content_type: 'image/jpg')
  i += 1
  p "creating #{file}: #{photo}"
end
puts 'finished'
