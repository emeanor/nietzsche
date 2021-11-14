class Book < ApplicationRecord

  belongs_to :edition
  acts_as_list scope: :edition

  has_many :chapters, -> { order(position: :asc) }

  validates :title, length: { maximum: 255 }, presence: true
  validates :subtitle, length: { maximum: 255 }

  def editor
    self.edition.user
  end
  
  def has_subtitle?
    self.subtitle.present?
  end

  def has_chapters?
    self.chapters.any?
  end

  def has_chapter?(chapter_id)
    self.chapters.where(id: chapter_id).exists?
  end

  def valid_position?(position)
    position.is_a?(Integer) && position > 0 && position <= self.chapters.maximum('position')
  end  

  def create_chapter(title, subtitle=nil, position=nil)
    chapter = self.chapters.create(title: title, subtitle: subtitle)
    move_chapter(chapter, position) unless position.nil?
    return chapter
  end

  def destroy_chapter(chapter)
    self.chapters.destroy(chapter.id) if self.has_chapter?(chapter)
  end

  def move_chapter(chapter, position)
    return unless self.has_chapter?(chapter)
    valid_position?(position) ? chapter.set_list_position(position) : chapter.move_to_bottom
  end

end