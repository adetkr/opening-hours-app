require 'rails_helper'

RSpec.describe ShopOpeningHour, type: :model do
  describe 'validations' do
    let(:shop) { Shop.create(name: 'name')}

    it { should validate_presence_of(:day) }
    it { should validate_presence_of(:open_at) }
    it { should validate_presence_of(:close_at) }

    context 'when break_ends_at is present' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: 10.hours.ago, close_at: 1.hour.ago, break_ends_at: 7.hours.ago)
      end
      it 'should validates presence of break_starts_at' do
        expect(shop_opening_hour).not_to be_valid
      end
    end

    context 'when break_starts_at is present' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: 10.hours.ago, close_at: 1.hour.ago, break_starts_at: 7.hours.ago)
      end
      it 'should validates presence of break_ends_at' do
        expect(shop_opening_hour).not_to be_valid
      end
    end

    context 'when open_at is greater than close_at' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: 1.hours.ago, close_at: 10.hour.ago)
      end
      it 'should validates close_at coherence' do
        expect(shop_opening_hour.errors.full_messages.to_sentence).to eq("Close at L'horaire de fermeture du magasin doit être après l'horaire d'ouverture du magasin")
      end
    end

    context 'when break_ends_at is greater than close_at' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: 10.hours.ago, close_at: 2.hour.ago, break_starts_at: 8.hours.ago, break_ends_at: 1.hours.ago)
      end
      it 'should validates close_at coherence' do
        expect(shop_opening_hour.errors.full_messages.to_sentence).to eq("Close at L'horaire de fermeture du magasin doit être après l'horaire de la fin de pause")
      end
    end

    context 'when break_starts_at is greater than break_ends_at' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: 10.hours.ago, close_at: 1.hour.ago, break_starts_at: 4.hours.ago, break_ends_at: 5.hours.ago)
      end
      it 'should validates break_ends_at coherence' do
        expect(shop_opening_hour.errors.full_messages.to_sentence).to eq("Break ends at L'horaire de la fin de pause doit être après l'horaire du début de la pause")
      end
    end

    context 'when open_at is greater than break_starts_at' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: 6.hours.ago, close_at: 1.hour.ago, break_starts_at: 7.hours.ago, break_ends_at: 4.hours.ago)
      end
      it 'should validates break_starts_at coherence' do
        expect(shop_opening_hour.errors.full_messages.to_sentence).to eq("Break starts at L'horaire du début de la pause doit être après l'horaire d'ouverture du magasin")
      end
    end
  end

  describe 'relations' do
    it { is_expected.to belong_to(:shop) }
  end
end
