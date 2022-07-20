# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ShopsController, type: :request do
  let!(:shop) { Shop.create(name: 'issou')}
  let(:monday_opening_hour) do
    ShopOpeningHour.create(shop_id: shop.id, closed: false, day: :monday, open_at: DateTime.new(1999, 6, 30, 12, 30, 15, 30), close_at: DateTime.new(1999, 6, 30, 12, 30, 19, 30))
  end

  describe 'show' do
    before do
      get "/shops/#{shop.id}"
    end

    it 'is successful' do
      expect(response).to be_successful
      expect(response.body).to include('issou')
      expect(response.body).to include("Ce magasin n'a pas d'horaires disponibles")
    end
  end

  describe 'index' do
    before do
      get "/shops"
    end

    it 'is successful' do
      expect(response).to be_successful
      expect(response.body).to include('issou')
    end
  end

  describe 'create' do
    let(:params) { { "shop" => { 'name': 'created shop' } } }

    context 'when params are valid' do
      it 'is successful' do
        expect { post '/shops', params: params }.to change(Shop, :count).by(1)
      end
    end

    context 'when params are not valid' do
      let(:params) { { "shop" => { 'name': nil } } }

      it 'does not create shop' do
        expect { post '/shops', params: params }.to change(Shop, :count).by(0)
      end
    end
  end
end
