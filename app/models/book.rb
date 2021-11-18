class Book < ApplicationRecord
  include Division

  belongs_to :edition
  acts_as_list scope: :edition

  has_many :chapters, -> { order(position: :asc) }

  alias_attribute :children, :chapters

  alias_method :add_chapter, :add_child
  alias_method :destroy_chapter, :destroy_child
  alias_method :move_chapter, :move_child

  validates :title, length: { maximum: 255 }, presence: true
  validates :subtitle, length: { maximum: 255 }

  def owner
    self.edition.owner
  end
  
  def has_subtitle?
    self.subtitle.present?
  end

end