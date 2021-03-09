class FlatsController < ApplicationController
  before_action :set_flat, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @flats = if user_signed_in?
               policy_scope(Flat).where("user_id != '#{current_user.id}'")
             else
               policy_scope(Flat).all
             end
    if params[:search].present?
      @search = Flat.global_search(params[:search])
    else
      @flats = if user_signed_in?
                 policy_scope(Flat).where("user_id != '#{current_user.id}'")
               else
                 policy_scope(Flat).all
               end
    end
  end

  def show
    @booking = Booking.new

    @markers =
      {
        lat: @flat.latitude,
        long: @flat.longitude,
        image_url: helpers.asset_url('marker-editor.svg')

      }
  end

  def new
    @flat = Flat.new
    authorize @flat
  end

  def create
    @user = User.find(current_user.id)
    @flat = Flat.new(set_params)
    @flat.user = @user
    authorize @flat

    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  def edit
    authorize @flat
  end

  def update
    @flat.update(set_params)
    authorize @flat
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  def destroy
    @flat.destroy

    redirect_to flats_path
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
    authorize @flat
  end

  def set_params
    params.require(:flat).permit(:name, :address, :description, :rating, :photo)
  end
end
