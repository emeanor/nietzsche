require 'rails_helper'

RSpec.describe EditionsController, type: :controller do

  let(:edition) { FactoryBot.create(:edition) }

  describe 'GET #index' do
    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'should render the show template' do
      get :show, params: { id: edition.id }
      expect(response).to render_template('show')
    end
  end

end