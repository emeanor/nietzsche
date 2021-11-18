class Text < ApplicationRecord

  before_validation :set_url_slug
  
  enum duplicate: [:a, :b]

  has_many :chapter_texts
  has_many :chapters, through: :chapter_texts

  validates :nietzsche_number, inclusion: 1..372, presence: true
  validates :book_number, inclusion: { in: 1..4, allow_nil: true }
  validates :kgw_notebook_number, inclusion: 9..11, presence: true
  validates :kgw_text_number, presence: true
  validates :title, length: { maximum: 255 }, presence: true
  validates :text, presence: true
  validates :url_slug, presence: true, uniqueness: { case_sensitive: false }

  def is_duplicate?
    self.duplicate.present?
  end
  
  def has_book_number?
    self.book_number.present?
  end

  def roman_book_number
    return unless self.has_book_number?

    case self.book_number
      when 1
        'I'
      when 2
        'II'
      when 3
        'III'
      when 4
        'IV'
    end
  end


  private

  def set_url_slug
    self.url_slug = self.is_duplicate? ? self.nietzsche_number.to_s << self.duplicate : self.nietzsche_number.to_s
  end
    
end
