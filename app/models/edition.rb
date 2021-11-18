class Edition < ApplicationRecord
  include Division

  belongs_to :user
  has_many :books, -> { order(position: :asc) }

  alias_attribute :children, :books

  alias_method :add_book, :add_child
  alias_method :destroy_book, :destroy_child
  alias_method :move_book, :move_child

  validates :title, length: { maximum: 255 }, presence: true
  validates :subtitle, length: { maximum: 255 }
  validates :user, presence: true

  def owner
    return self.user
  end

  def has_editor_intro?
    self.editor_intro.present?
  end

end