require 'rails_helper'

RSpec.describe Report do
  let!(:user) { create(:user) }

  describe '#editable?' do
    let!(:report) { create(:report, user: user) }

    context 'when the user is the owner of the report' do
      it 'is editable' do
        expect(report.editable?(user)).to eq true
      end
    end

    context 'when the user is not the owner of the report' do
      let!(:other_user) { create(:user) }

      it 'is not editable' do
        expect(report.editable?(other_user)).to eq false
      end
    end
  end

  describe '#created_on' do
    it 'returns the date when the report was created' do
      travel_to Time.zone.local(2023, 8, 30, 01, 04, 44) do
        report = FactoryBot.create(:report, user: user)
        expect(report.created_on).to eq Date.new(2023, 8, 30)
      end
    end
  end
end
