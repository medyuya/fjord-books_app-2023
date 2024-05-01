require 'rails_helper'

RSpec.describe Report, type: :model do
  let!(:user) { create(:user) }

  describe '#editable?' do
    let!(:report) { create(:report, user: user) }

    context 'when the user is the owner of the report' do
      it 'returns the true' do
        expect(report.editable?(user)).to eq true
      end
    end

    context 'when the user is not the owner of the report' do
      let!(:other_user) { create(:user) }

      it 'returns the false' do
        expect(report.editable?(other_user)).to eq false
      end
    end
  end

  describe '#created_on' do
    it 'returns the date when the report was created' do
      travel_to Time.zone.local(2023, 8, 30) do
        report = FactoryBot.create(:report, user: user)
        expect(report.created_on).to eq Date.new(2023, 8, 30)
      end
    end
  end
end
