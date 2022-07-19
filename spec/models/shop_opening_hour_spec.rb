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
  end

  describe 'relations' do
    it { is_expected.to belong_to(:shop) }
  end
end
