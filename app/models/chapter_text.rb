class ChapterText < ApplicationRecord

  acts_as_list scope: :chapter

  belongs_to :chapter
  belongs_to :text

end
