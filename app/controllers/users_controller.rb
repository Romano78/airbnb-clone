class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @booked_flats = current_user.flats.select do |item|
      item.bookings.size > 0
    end
  end
end
