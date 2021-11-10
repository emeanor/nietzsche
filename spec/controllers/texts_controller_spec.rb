require 'rails_helper'

RSpec.describe TextsController, type: :controller do

  let(:text) { FactoryBot.create(:text) }

  describe 'GET #index' do
    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'should render the show template' do
      get :show, params: { url_slug: text.url_slug }
      expect(response).to render_template('show')
    end
  end

end