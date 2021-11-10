require 'rails_helper'

RSpec.describe User, type: :model do
  
  it { should have_many(:editions) }
  it { should validate_presence_of(:username) }

  let(:user) { create(:user) }

  it 'should have a valid factory' do
    expect(user).to be_valid
  end

end