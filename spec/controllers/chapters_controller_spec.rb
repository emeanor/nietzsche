require 'rails_helper'

RSpec.describe ChaptersController, type: :controller do

  let(:edition) { FactoryBot.create(:edition) }
  let(:book) { FactoryBot.create(:book, edition: edition) }
  let(:chapter) { FactoryBot.create(:chapter, book: book) }

  describe 'GET #show' do
    it 'should render the show template' do
      get :show, params: { edition_id: edition.id, book_position: book.position, position: chapter.position }
      expect(response).to render_template('show')
    end
  end

end