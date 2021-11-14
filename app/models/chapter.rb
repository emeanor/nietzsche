class Chapter < ApplicationRecord

  belongs_to :book
  acts_as_list scope: :book

  has_many :chapter_texts
  has_many :texts, -> { order(position: :asc) }, through: :chapter_texts

  validates :title, length: { maximum: 255 }, presence: true
  validates :subtitle, length: { maximum: 255 }

  def edition
    self.book.edition
  end

  def editor
    self.edition.user
  end
  
  def has_subtitle?
    self.subtitle.present?
  end

  def has_text?(text_id)
    self.texts.where(id: text_id).exists?
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
