require 'faker'

puts 'creating seed...'
bob = User.new(name: 'bob', last_name: 'sponge', admin: true, email: 'bob@sponge.com', password: '222222')

bob.save

puts "creating #{bob}"

3.times do
  flats = Flat.new(
    name: Faker::TvShows::SouthPark.character,
    address: Faker::Address.street_address,
    description: Faker::TvShows::SouthPark.quote,
    rating: (1..5).to_a.sample,
    user_id: bob.id
  )

  flats.save

  puts "saving #{flats}"
end

puts 'finished'
