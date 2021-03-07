require 'faker'

puts "deleting Bookings: #{Booking.destroy_all}"
puts "deleting Users: #{User.destroy_all}"
puts "deleting Flats: #{Flat.destroy_all}"

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

  puts "saving #{bob_flat}"

  bill_flat =  Flat.new(
    name: Faker::TvShows::SouthPark.character,
    address: Faker::Address.street_address,
    description: Faker::TvShows::SouthPark.quote,
    rating: (1..5).to_a.sample,
    user_id: bill.id
  )

  bill_flat.save

  puts "saving #{bill_flat}"
end

puts 'finished'
