require 'rails_helper'

RSpec.describe ShopsHelper, type: :helper do
  let(:shop) { Shop.create(name: 'name')}
  let(:current_opening_hour) do
    ShopOpeningHour.create(shop: shop, closed: true, day: :monday, open_at: DateTime.new(1999, 6, 30, 12, 30), close_at: DateTime.new(1999, 6, 30, 13, 30), break_ends_at: DateTime.new(1999, 6, 30, 12, 45))
  end

  describe '#presenter' do
    subject { helper.send(:presenter, current_opening_hour) }

    it { is_expected.to eq 'Lundi  Fermé' }

    context 'when the opening hour does not include break' do
      let(:current_opening_hour) do
        ShopOpeningHour.create(shop: shop, closed: false, day: :monday, open_at: DateTime.new(1999, 6, 30, 8, 30), close_at: DateTime.new(1999, 6, 30, 18, 30), break_ends_at: DateTime.new(1999, 6, 30, 16, 30))
      end

      it { is_expected.to eq 'Lundi  08h30-18h30' }
    end

    context 'when the opening hour includes a break' do
      let(:current_opening_hour) do
        ShopOpeningHour.create(shop: shop, closed: false, day: :monday, open_at: DateTime.new(1999, 6, 30, 7, 30), close_at: DateTime.new(1999, 6, 30, 20, 30), break_ends_at: DateTime.new(1999, 6, 30, 13, 30), break_starts_at: DateTime.new(1999, 6, 30, 12, 30))
      end

      it { is_expected.to eq 'Lundi  07h30-12h30, 13h30-20h30' }
    end
  end
end
