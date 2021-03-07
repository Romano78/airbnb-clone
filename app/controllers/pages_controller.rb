class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home; end

  def dashboard
    @booked_flats = current_user.flats.select do |item|
      item.bookings.size > 0
    end

    @rentals = current_user.bookings
    @flats = current_user.flats
  end
end
