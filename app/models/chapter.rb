class Chapter < ApplicationRecord
  include Division

  belongs_to :book
  acts_as_list scope: :book

  has_many :chapter_texts
  has_many :texts, -> { order(position: :asc) }, through: :chapter_texts

  alias_attribute :children, :texts

  alias_method :has_texts?, :has_children?
  alias_method :has_text?, :has_child?

  validates :title, length: { maximum: 255 }, presence: true
  validates :subtitle, length: { maximum: 255 }

  def edition
    self.book.owner
  end

  def owner
    self.edition.user
  end

  def valid_position?(position)
    position.is_a?(Integer) && position > 0 && position <= self.chapter_texts.maximum('position')
  end

  def add_text(text, position=nil)
    self.texts << text unless self.has_text?(text.id)
    move_text(text, position) unless position.nil?
    return text
  end

  def remove_text(text)
    return unless self.has_text?(text.id)
    self.chapter_texts.destroy(self.chapter_texts.where(text: text).first.id)
  end

  def move_text(text, position)
    return unless self.has_text?(text) && position.is_a?(Integer)

    chapter_text = self.chapter_texts.where(text: text).first
    valid_position?(position) ? chapter_text.set_list_position(position) : chapter_text.move_to_bottom
  end
  
end
