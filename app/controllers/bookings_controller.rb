class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    authorize @booking
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new(set_booking_params)
    @booking.flat = @flat
    @booking.user = current_user
    @booking.status = 'Pending'
    authorize @booking
    if @booking.save!
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.status = params[:status]
    @booking.save!
    redirect_to dashboard_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
  end

  private

  def set_booking_params
    params.require(:booking).permit(:status, :start_date, :end_date)
  end
end
