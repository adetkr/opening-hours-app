class ShopsController < ApplicationController
  before_action :set_shop, only: [:update, :edit]

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.includes(:shop_opening_hours).find(params[:id])
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to shop_path(@shop)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @shop.update(shop_params)
      redirect_to shop_path(@shop)
    else
      render :edit
    end
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:name, shop_opening_hours_attributes: [:id, :day, :open_at, :break_starts_at, :break_ends_at, :close_at, :closed, :_destroy])
  end
end
