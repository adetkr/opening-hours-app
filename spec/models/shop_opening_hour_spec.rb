require 'rails_helper'

RSpec.describe ShopOpeningHour, type: :model do
  let(:shop) { Shop.create(name: 'name')}

  describe 'validations' do
    it { should validate_presence_of(:day) }
    it { should validate_presence_of(:open_at) }
    it { should validate_presence_of(:close_at) }

    context 'when break_ends_at is present' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: DateTime.new(1999, 6, 30, 8, 30), close_at: DateTime.new(1999, 6, 30, 12, 30), break_ends_at: DateTime.new(1999, 6, 30, 9, 30))
      end
      it 'should validates presence of break_starts_at' do
        expect(shop_opening_hour).not_to be_valid
      end
    end

    context 'when break_starts_at is present' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: DateTime.new(1999, 6, 30, 8, 30), close_at: DateTime.new(1999, 6, 30, 12, 30), break_starts_at: DateTime.new(1999, 6, 30, 9, 30))
      end
      it 'should validates presence of break_ends_at' do
        expect(shop_opening_hour).not_to be_valid
      end
    end

    context 'when open_at is greater than close_at' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: DateTime.new(1999, 6, 30, 12, 30), close_at: DateTime.new(1999, 6, 30, 8, 30))
      end
      it 'should validates close_at coherence' do
        expect(shop_opening_hour.errors.full_messages.to_sentence).to eq("Close at L'horaire de fermeture du magasin doit être après l'horaire d'ouverture du magasin")
      end
    end

    context 'when break_ends_at is greater than close_at' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: DateTime.new(1999, 6, 30, 8, 30), close_at: DateTime.new(1999, 6, 30, 12, 30), break_starts_at: DateTime.new(1999, 6, 30, 9, 30), break_ends_at: DateTime.new(1999, 6, 30, 15, 30))
      end
      it 'should validates close_at coherence' do
        expect(shop_opening_hour.errors.full_messages.to_sentence).to eq("Close at L'horaire de fermeture du magasin doit être après l'horaire de la fin de pause")
      end
    end

    context 'when break_starts_at is greater than break_ends_at' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: DateTime.new(1999, 6, 30, 8, 30), close_at: DateTime.new(1999, 6, 30, 12, 30), break_starts_at: DateTime.new(1999, 6, 30, 10, 30), break_ends_at: DateTime.new(1999, 6, 30, 9, 30))
      end
      it 'should validates break_ends_at coherence' do
        expect(shop_opening_hour.errors.full_messages.to_sentence).to eq("Break ends at L'horaire de la fin de pause doit être après l'horaire du début de la pause")
      end
    end

    context 'when open_at is greater than break_starts_at' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: DateTime.new(1999, 6, 30, 8, 30), close_at: DateTime.new(1999, 6, 30, 12, 30), break_starts_at: DateTime.new(1999, 6, 30, 7, 30), break_ends_at: DateTime.new(1999, 6, 30, 11, 30))
      end
      it 'should validates break_starts_at coherence' do
        expect(shop_opening_hour.errors.full_messages.to_sentence).to eq("Break starts at L'horaire du début de la pause doit être après l'horaire d'ouverture du magasin")
      end
    end
  end

  describe 'relations' do
    it { is_expected.to belong_to(:shop) }
  end

  describe '#break_hours_filled?' do
    context 'when break hours are not filled' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: DateTime.new(1999, 6, 30, 8, 30), close_at: DateTime.new(1999, 6, 30, 12, 30), break_ends_at: DateTime.new(1999, 6, 30, 11, 30))
      end

      it 'returns false' do
        expect(shop_opening_hour.break_hours_filled?).to be_falsy
      end
    end

    context 'when break hours are filled' do
      let(:shop_opening_hour) do
        ShopOpeningHour.create(shop: shop, day: :monday, open_at: DateTime.new(1999, 6, 30, 8, 30), close_at: DateTime.new(1999, 6, 30, 12, 30), break_starts_at: DateTime.new(1999, 6, 30, 11, 00), break_ends_at: DateTime.new(1999, 6, 30, 11, 30))
      end

      it 'returns true' do
        expect(shop_opening_hour.break_hours_filled?).to be_truthy
      end
    end
  end
end
