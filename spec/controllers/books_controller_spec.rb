require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  let(:edition) { FactoryBot.create(:edition) }
  let(:book) { FactoryBot.create(:book, edition: edition) }

  describe 'GET #show' do
    it 'should render the show template' do
      get :show, params: { edition_id: edition.id, position: book.position }
      expect(response).to render_template('show')
    end
  end

end