require 'rails_helper'

RSpec.describe Shop, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:shop_opening_hours).dependent(:destroy) }
  end
end
