class Edition < ApplicationRecord

  belongs_to :user
  has_many :books, -> { order(position: :asc) }

  validates :title, length: { maximum: 255 }, presence: true
  validates :subtitle, length: { maximum: 255 }
  validates :user, presence: true

  def editor
    return self.user
  end
  
  def has_subtitle?
    self.subtitle.present?
  end

  def has_editor_intro?
    self.editor_intro.present?
  end

  def has_book?(book_id)
    self.books.where(id: book_id).exists?
  end

  def valid_position?(position)
    position.is_a?(Integer) && position > 0 && position <= self.books.maximum('position')
  end  

  def create_book(title, subtitle=nil, position=nil)
    book = self.books.create(title: title, subtitle: subtitle)
    move_book(book, position) unless position.nil?
    return book
  end

  def destroy_book(book)
    self.books.destroy(book.id) if self.has_book?(book)
  end

  def move_book(book, position)
    return unless self.has_book?(book)
    valid_position?(position) ? book.set_list_position(position) : book.move_to_bottom
  end

end