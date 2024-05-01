require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name_or_email' do
    context 'when the name is present' do
      let!(:user) { create(:user, name: 'ケン') }

      it 'returns the name' do
        expect(user.name_or_email).to eq 'ケン'
      end
    end

    context 'when the name is not present' do
      let!(:user) { create(:user, email: 'ken@example.com', name: '') }

      it 'returns the email' do
        expect(user.name_or_email).to eq 'ken@example.com'
      end
    end
  end
end
