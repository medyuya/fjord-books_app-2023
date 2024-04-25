require 'rails_helper'

RSpec.describe Report, type: :model do
  describe '#editable?' do
    let!(:user) { create(:user, name: 'ケン') }
    let!(:report) { create(:report, user: user) }

    context 'when the user is the owner of the report' do
      it 'returns the true' do
        expect(report.editable?(user)).to eq true
      end
    end

    context 'when the user is not the owner of the report' do
      let!(:other_user) { create(:user, name: 'ジン') }

      it 'returns the false' do
        expect(report.editable?(other_user)).to eq false
      end
    end
  end
end
